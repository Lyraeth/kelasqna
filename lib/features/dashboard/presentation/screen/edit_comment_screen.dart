import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kelasqna/kelasqna.dart';

class EditCommentScreen extends StatefulWidget {
  const EditCommentScreen({
    super.key,
    required this.commentEntity,
    required this.questionEntity,
  });

  final CommentsEntity commentEntity;

  final QuestionEntity questionEntity;

  @override
  State<EditCommentScreen> createState() => EditCommentScreenState();
}

class EditCommentScreenState extends State<EditCommentScreen> {
  late final TextEditingController _contentController = TextEditingController(
    text: widget.commentEntity.content,
  );

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  void _editQuestion() {
    context.read<EditCommentBloc>().add(
      EditCommentEvent.editComment(
        widget.questionEntity.id,
        widget.commentEntity.id,
        content: _contentController.text.trim(),
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
            context.l10n.editComment,
            style: context.text.titleLarge?.copyWith(
              color: context.colors.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),

          8.h,

          NeoKelasTextFormField(
            controller: _contentController,
            textFieldName: context.l10n.comments,
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
                        context.l10n.editComment,
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
