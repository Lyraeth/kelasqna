import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kelasqna/kelasqna.dart';

class QnaDetailScreen extends StatefulWidget {
  const QnaDetailScreen({super.key, required this.questionEntity});

  final QuestionEntity questionEntity;

  @override
  State<QnaDetailScreen> createState() => _QnaDetailScreenState();
}

class _QnaDetailScreenState extends State<QnaDetailScreen> {
  @override
  void initState() {
    _fetchQuestion();
    super.initState();
  }

  void _fetchQuestion() {
    context.read<QuestionBloc>().add(
      QuestionEvent.fetchQuestion(widget.questionEntity.id, forceRefresh: true),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        QnaCardHeader(
          questionEntity: widget.questionEntity,
          showTrailing: false,
        ),
        Container(
          padding: 16.all,
          child: QnaCardBody(
            questionEntity: widget.questionEntity,
            backgroundTransparent: false,
            rounded: true,
          ),
        ),
        BlocBuilder<QuestionBloc, QuestionState>(
          builder: (context, state) {
            return state.maybeWhen(
              success: (question) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final comments = question.listComments?[index];

                        return QnaCommentContainer(
                          userName: comments?.author.name ?? "-",
                          userComment: comments?.content ?? "-",
                        );
                      },
                      separatorBuilder: (context, index) => 8.h,
                      itemCount: question.listComments?.length ?? 0,
                    ),
                  ],
                );
              },
              emptyComment: () => Center(
                child: Text(
                  context.l10n.emptyComments,
                  style: context.text.titleMedium?.copyWith(
                    color: context.colors.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              loading: () => Center(child: CircularProgressIndicator()),
              orElse: () => SizedBox.shrink(),
            );
          },
        ),
      ],
    );
  }
}
