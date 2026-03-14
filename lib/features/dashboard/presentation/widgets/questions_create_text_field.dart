import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kelasqna/kelasqna.dart';

class QuestionsCreateTextField extends StatelessWidget {
  const QuestionsCreateTextField({super.key, this.forEmptyData = false});

  final bool forEmptyData;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showCupertinoSheet(
        context: context,
        builder: (context) =>
            Material(child: SafeArea(child: CreateQuestionScreen())),
      ),
      child: AbsorbPointer(
        child: NeoKelasTextFormField(
          textFieldBackgroundColor: context.colors.surface,
          margin: forEmptyData ? 16.horizontal : null,
          hintText: context.l10n.writeQuestions,
          readOnly: true,
        ),
      ),
    );
  }
}
