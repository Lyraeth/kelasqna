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
    this.shape,
  });

  /// Default [Offset(3, 3)].
  final Offset? offset;

  /// Default [context.colors.surface].
  final Color? backgroundColor;

  /// Default [context.colors.shadow].
  final Color? shadowsColor;

  /// Default [context.colors.shadow].
  final Color? borderColor;

  /// Default 3.
  final double? borderWidth;
  final Widget child;

  /// Default [8.all].
  final EdgeInsetsGeometry? padding;

  /// No default.
  final EdgeInsetsGeometry? margin;

  /// Default [8.all]
  final BorderRadiusGeometry? borderRadius;

  /// No default.
  final double? width;

  /// No default.
  final double? height;

  /// Default [BoxShape.rectangle]
  final BoxShape? shape;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding ?? 8.all,
      decoration: BoxDecoration(
        borderRadius: (shape == BoxShape.circle) ? borderRadius : 8.circular,
        border: Border.all(
          color: borderColor ?? context.colors.shadow,
          width: borderWidth ?? 3,
        ),
        color: backgroundColor ?? context.colors.surface,
        boxShadow: [
          BoxShadow(
            color: shadowsColor ?? context.colors.shadow,
            blurRadius: 0,
            offset: offset ?? const Offset(3, 3),
            blurStyle: BlurStyle.solid,
          ),
        ],
        shape: shape ?? BoxShape.rectangle,
      ),
      clipBehavior: Clip.antiAlias,
      child: child,
    );
  }
}
