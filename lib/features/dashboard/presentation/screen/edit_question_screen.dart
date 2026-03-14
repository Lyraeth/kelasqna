import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kelasqna/kelasqna.dart';

class EditQuestionScreen extends StatefulWidget {
  const EditQuestionScreen({super.key, required this.questionEntity});

  final QuestionEntity questionEntity;

  @override
  State<EditQuestionScreen> createState() => EditQuestionScreenState();
}

class EditQuestionScreenState extends State<EditQuestionScreen> {
  late final TextEditingController _titleController = TextEditingController(
    text: widget.questionEntity.title,
  );
  late final TextEditingController _descriptionController =
      TextEditingController(text: widget.questionEntity.content);

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _editQuestion() {
    final EditQuestionParams params = EditQuestionParams(
      title: _titleController.text.trim(),
      content: _descriptionController.text.trim(),
    );

    context.read<EditQuestionBloc>().add(
      EditQuestionEvent.editQuestion(
        widget.questionEntity.id,
        editQuestionParams: params,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 16.all,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.editQuestion,
            style: context.text.titleLarge?.copyWith(
              color: context.colors.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),

          8.h,

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

          BlocBuilder<EditQuestionBloc, EditQuestionState>(
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

                  _editQuestion();
                },
                child: isLoading
                    ? CircularProgressIndicator()
                    : Text(
                        context.l10n.editQuestion,
                        style: context.text.bodyMedium?.copyWith(
                          color: context.colors.onPrimaryContainer,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              );
            },
          ),
        ].separatedBy(16.h),
      ),
    );
  }
}
