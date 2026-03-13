import 'package:flutter/material.dart';
import 'package:kelasqna/kelasqna.dart';

class QnaCardBody extends StatelessWidget {
  const QnaCardBody({
    super.key,
    required this.questionEntity,
    required this.rounded,
    this.padding,
    this.margin,
    this.backgroundTransparent = true,
  });

  final QuestionEntity questionEntity;

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
          questionEntity.title,
          style: context.text.titleMedium?.copyWith(
            color: context.colors.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: NeoKelasBackgroundContainer(
          padding: 8.onlyTop,
          child: Text(
            questionEntity.content,
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
