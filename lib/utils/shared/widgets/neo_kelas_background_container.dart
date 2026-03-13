import 'package:flutter/material.dart';
import 'package:kelasqna/kelasqna.dart';

class NeoKelasBackgroundContainer extends StatelessWidget {
  const NeoKelasBackgroundContainer({
    super.key,
    required this.child,
    this.margin,
    this.padding,
    this.backgroundTransparent = true,
    this.rounded = false,
  });

  final Widget child;

  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final bool backgroundTransparent;
  final bool rounded;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundTransparent
            ? Colors.transparent
            : context.colors.surfaceContainerLow,
        borderRadius: rounded ? 16.circular : null,
      ),
      child: child,
    );
  }
}
