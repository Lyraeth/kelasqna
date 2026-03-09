import 'package:flutter/material.dart';
import 'package:kelasqna/kelasqna.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

enum ToastType { error, success, warning, info }

class NeoKelasAppToast {
  static OverlayEntry? _currentEntry;

  static void show(
    BuildContext context, {
    required String message,
    ToastType type = ToastType.error,
    Duration duration = const Duration(seconds: 3),
  }) {
    _currentEntry?.remove();

    final overlay = Overlay.of(context);
    late OverlayEntry entry;

    entry = OverlayEntry(
      builder: (_) => _ToastWidget(
        message: message,
        type: type,
        onDismiss: () {
          entry.remove();
          _currentEntry = null;
        },
        duration: duration,
      ),
    );

    _currentEntry = entry;
    overlay.insert(entry);
  }
}

class _ToastWidget extends StatefulWidget {
  final String message;
  final ToastType type;
  final VoidCallback onDismiss;
  final Duration duration;

  const _ToastWidget({
    required this.message,
    required this.type,
    required this.onDismiss,
    required this.duration,
  });

  @override
  State<_ToastWidget> createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<_ToastWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnim;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 1.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _fadeAnim = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _controller.forward();

    // auto dismiss
    Future.delayed(widget.duration, _dismiss);
  }

  void _dismiss() async {
    if (!mounted) return;
    await _controller.reverse();
    widget.onDismiss();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color get _backgroundColor => switch (widget.type) {
    ToastType.error => context.colors.errorContainer,
    ToastType.success => Colors.greenAccent,
    ToastType.warning => Colors.yellowAccent,
    ToastType.info => context.colors.secondaryContainer,
  };

  IconData get _icon => switch (widget.type) {
    ToastType.error => LucideIcons.ban,
    ToastType.success => LucideIcons.circleCheck,
    ToastType.warning => LucideIcons.circleAlert,
    ToastType.info => LucideIcons.info,
  };

  Color get _textColor => switch (widget.type) {
    ToastType.error => context.colors.onErrorContainer,
    ToastType.success => context.colors.surface,
    ToastType.warning => context.colors.surface,
    ToastType.info => context.colors.onSecondaryContainer,
  };

  Color get _iconColor => switch (widget.type) {
    ToastType.error => context.colors.onErrorContainer,
    ToastType.success => context.colors.surface,
    ToastType.warning => context.colors.surface,
    ToastType.info => context.colors.onSecondaryContainer,
  };

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: context.padding.bottom + 24,
      left: 16,
      right: 16,
      child: SlideTransition(
        position: _slideAnim,
        child: FadeTransition(
          opacity: _fadeAnim,
          child: Material(
            color: Colors.transparent,
            child: GestureDetector(
              onTap: _dismiss,
              child: NeoKelasContainer(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 6,
                ),
                backgroundColor: _backgroundColor,
                child: Row(
                  children: [
                    Icon(_icon, color: _iconColor),
                    16.w,
                    Expanded(
                      child: Text(
                        widget.message,
                        style: context.text.bodyMedium?.copyWith(
                          color: _textColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: _dismiss,
                      child: Icon(
                        LucideIcons.circleX,
                        color: _textColor,
                        size: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
