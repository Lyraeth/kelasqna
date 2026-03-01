import 'package:flutter/material.dart';
import 'package:kelasqna/kelasqna.dart';

class NeoKelasButton extends StatefulWidget {
  final GestureTapCallback? onPressed;
  final Color buttonColor;
  final Widget child;
  final EdgeInsetsGeometry? padding;

  const NeoKelasButton({
    super.key,
    this.onPressed,
    required this.buttonColor,
    required this.child,
    this.padding,
  });

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
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 100))
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
    return InkWell(
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
          padding: widget.padding,
          containerColor: widget.buttonColor,
          child: Center(child: widget.child),
        ),
      ),
    );
  }
}
