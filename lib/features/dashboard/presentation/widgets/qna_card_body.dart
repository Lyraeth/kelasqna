import 'package:flutter/material.dart';
import 'package:kelasqna/kelasqna.dart';

class QnaCardBody extends StatelessWidget {
  const QnaCardBody({
    super.key,
    required this.title,
    required this.body,
    required this.rounded,
    this.padding,
    this.margin,
    this.backgroundTransparent = true,
  });

  /// Title question.
  final String title;

  /// Body question.
  final String body;

  final bool rounded;

  final EdgeInsetsGeometry? padding;

  final EdgeInsetsGeometry? margin;

  final bool backgroundTransparent;

  @override
  Widget build(BuildContext context) {
    return NeoKelasBackgroundContainer(
      padding: padding,
      margin: margin,
      rounded: rounded,
      backgroundTransparent: backgroundTransparent,
      child: ListTile(
        title: Text(
          title,
          style: context.text.titleMedium?.copyWith(
            color: context.colors.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: NeoKelasBackgroundContainer(
          padding: 8.onlyTop,
          child: Text(
            body,
            style: context.text.labelLarge?.copyWith(
              color: context.colors.onSurfaceVariant,
            ),
            textAlign: TextAlign.justify,
          ),
        ),
      ),
    );
  }
}
