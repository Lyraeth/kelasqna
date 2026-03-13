import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:kelasqna/kelasqna.dart';

class NeoKelasButton extends StatefulWidget {
  const NeoKelasButton({
    super.key,
    this.onPressed,
    this.backgroundColor,
    required this.child,
    this.padding,
    this.margin,
    this.shape,
    this.height,
    this.width,
  });

  final GestureTapCallback? onPressed;
  final Color? backgroundColor;
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BoxShape? shape;
  final double? width;
  final double? height;

  @override
  State<NeoKelasButton> createState() => _NeoKelasButtonState();
}

class _NeoKelasButtonState extends State<NeoKelasButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: 100.milliseconds)
      ..addListener(() {
        setState(() {});
      });
    _animation = Tween<Offset>(
      begin: const Offset(0, 0),
      end: Offset(4, 4),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.bounceInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed == null
          ? null
          : () {
              _controller.forward().then((value) {
                widget.onPressed?.call();
                _controller.reverse();
              });
            },
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Transform.translate(offset: _animation.value, child: child);
        },
        child: NeoKelasContainer(
          width: widget.width,
          height: widget.height,
          margin: widget.margin,
          padding: widget.padding ?? 16.vertical,
          shape: widget.shape,
          backgroundColor: widget.backgroundColor,
          child: Center(child: widget.child),
        ),
      ),
    );
  }
}
