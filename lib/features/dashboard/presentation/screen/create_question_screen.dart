import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kelasqna/kelasqna.dart';

class CreateQuestionScreen extends StatefulWidget {
  const CreateQuestionScreen({super.key});

  @override
  State<CreateQuestionScreen> createState() => _CreateQuestionScreenState();
}

class _CreateQuestionScreenState extends State<CreateQuestionScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _createQuestion() {
    final QuestionParams params = QuestionParams(
      title: _titleController.text.trim(),
      content: _descriptionController.text.trim(),
    );

    context.read<CreateQuestionBloc>().add(
      CreateQuestionEvent.createQuestion(questionParams: params),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Text(
          context.l10n.createQuestion,
          style: context.text.titleLarge?.copyWith(
            color: context.colors.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: 16.all,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NeoKelasTextFormField(
              controller: _titleController,
              textFieldName: context.l10n.titleQuestion,
              hintText: " ",
              maxLines: null,
            ),
            NeoKelasTextFormField(
              controller: _descriptionController,
              textFieldName: context.l10n.descriptionQuestion,
              hintText: " ",
              height: 104,
              maxLines: 8,
              minLines: 4,
              textAlignVertical: TextAlignVertical.top,
            ),

            const Spacer(),

            BlocBuilder<CreateQuestionBloc, CreateQuestionState>(
              builder: (context, state) {
                final isLoading = state.maybeWhen(
                  loading: () => true,
                  orElse: () => false,
                );

                return NeoKelasButton(
                  backgroundColor: context.colors.primaryContainer,
                  onPressed: () {
                    if (isLoading) return;

                    FocusScope.of(context).unfocus();

                    _createQuestion();
                  },
                  child: isLoading
                      ? CircularProgressIndicator()
                      : Text(
                          context.l10n.createQuestion,
                          style: context.text.bodyMedium?.copyWith(
                            color: context.colors.onPrimaryContainer,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                );
              },
            ),
          ].separatedBy(24.h),
        ),
      ),
    );
  }
}
