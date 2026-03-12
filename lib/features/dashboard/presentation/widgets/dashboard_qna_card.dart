import 'package:flutter/material.dart';
import 'package:kelasqna/kelasqna.dart';

class DashboardQnaCard extends StatelessWidget {
  const DashboardQnaCard({super.key, required this.questionEntity, this.onTap});

  final QuestionEntity questionEntity;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: NeoKelasContainer(
        padding: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            QnaCardHeader(questionEntity: questionEntity, showTrailing: false),

            // Body
            QnaCardBody(
              backgroundTransparent: false,
              rounded: false,
              questionEntity: questionEntity,
            ),

            // Footer
            QnaCardFooter(
              questionEntity: questionEntity,
              createdAt: questionEntity.createdAt,
            ),
          ],
        ),
      ),
    );
  }
}
