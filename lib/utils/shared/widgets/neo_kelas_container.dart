import 'package:flutter/material.dart';
import 'package:kelasqna/kelasqna.dart';

class NeoKelasContainer extends StatelessWidget {
  const NeoKelasContainer({
    super.key,
    this.backgroundColor,
    required this.child,
    this.offset,
    this.shadowsColor,
    this.borderColor,
    this.padding,
    this.margin,
    this.borderRadius,
    this.width,
    this.height,
    this.borderWidth,
  });

  final Offset? offset;
  final Color? backgroundColor;
  final Color? shadowsColor;
  final Color? borderColor;
  final double? borderWidth;
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadiusGeometry? borderRadius;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding ?? 8.all,
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? 8.circular,
        border: Border.all(
          color: borderColor ?? context.colors.shadow,
          width: borderWidth ?? 3,
        ),
        color: backgroundColor ?? context.colors.surfaceContainer,
        boxShadow: [
          BoxShadow(
            color: shadowsColor ?? context.colors.shadow,
            blurRadius: 0,
            offset: offset ?? const Offset(4, 4),
            blurStyle: BlurStyle.solid,
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: child,
    );
  }
}
