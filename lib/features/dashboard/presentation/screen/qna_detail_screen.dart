import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kelasqna/kelasqna.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class QnaDetailScreen extends StatefulWidget {
  const QnaDetailScreen({super.key, required this.questionEntity});

  final QuestionEntity questionEntity;

  @override
  State<QnaDetailScreen> createState() => _QnaDetailScreenState();
}

class _QnaDetailScreenState extends State<QnaDetailScreen> {
  final TextEditingController _commentController = TextEditingController();
  final FocusNode _commentFocusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    _fetchQuestion();
    _commentFocusNode.addListener(() {
      setState(() => _isFocused = _commentFocusNode.hasFocus);
    });
    super.initState();
  }

  @override
  void dispose() {
    _commentController.dispose();
    _commentFocusNode.dispose();
    super.dispose();
  }

  void _fetchQuestion() {
    context.read<QuestionBloc>().add(
      QuestionEvent.fetchQuestion(widget.questionEntity.id, forceRefresh: true),
    );
  }

  void _submitComment() {
    final text = _commentController.text.trim();
    if (text.isEmpty) return;

    context.read<CreateCommentBloc>().add(
      CreateCommentEvent.createComment(widget.questionEntity.id, content: text),
    );

    _commentController.clear();
    _commentFocusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return CommentsBlocListener(
      questionId: widget.questionEntity.id,
      child: Scaffold(
        body: Column(
          children: [
            // ── Scrollable Content ──────────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    QnaCardHeader(
                      questionEntity: widget.questionEntity,
                      showTrailing: false,
                    ),

                    // Body
                    QnaCardBody(
                      margin: 16.all,
                      questionEntity: widget.questionEntity,
                      backgroundTransparent: false,
                      rounded: true,
                    ),

                    // Comment Section Header
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                      child: Row(
                        children: [
                          Icon(
                            LucideIcons.messageCircle,
                            size: 16,
                            color: context.colors.primary,
                          ),
                          Text(
                            context.l10n.comments,
                            style: context.text.labelLarge?.copyWith(
                              color: context.colors.onSurface,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ].separatedBy(8.w),
                      ),
                    ),

                    // Comments List
                    BlocBuilder<QuestionBloc, QuestionState>(
                      builder: (context, state) {
                        return state.maybeWhen(
                          success: (question) {
                            final comments = question.listComments ?? [];

                            if (comments.isEmpty) {
                              return _EmptyCommentWidget();
                            }

                            return ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.fromLTRB(
                                16,
                                0,
                                16,
                                100,
                              ),
                              itemCount: comments.length,
                              separatorBuilder: (_, _) => 8.h,
                              itemBuilder: (context, index) {
                                final comment = comments[index];
                                return CommentDismissible(
                                  questionEntity: widget.questionEntity,
                                  commentEntity: comment,
                                  child: QnaCommentContainer(
                                    userName: comment.author.name,
                                    userComment: comment.content,
                                    userTimeComment: comment.createdAt,
                                  ),
                                );
                              },
                            );
                          },
                          emptyComment: () => _EmptyCommentWidget(),
                          loading: () => CommentListShimmer(),
                          orElse: () => const SizedBox.shrink(),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            // ── Post Comment Input Bar ──────────────────────────────
            _CommentInputBar(
              controller: _commentController,
              focusNode: _commentFocusNode,
              isFocused: _isFocused,
              onSubmit: _submitComment,
            ),
          ],
        ),
      ),
    );
  }
}

// ── Empty Comment Widget ────────────────────────────────────────────────────

class _EmptyCommentWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 16),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              LucideIcons.messageCircleDashed,
              size: 40,
              color: context.colors.onSurface.withValues(alpha: 0.3),
            ),
            12.h,
            Text(
              context.l10n.emptyComments,
              style: context.text.bodyMedium?.copyWith(
                color: context.colors.onSurface.withValues(alpha: 0.4),
                fontWeight: FontWeight.w500,
              ),
            ),
            8.h,
            Text(
              context.l10n.beTheFirstToComment,
              style: context.text.bodySmall?.copyWith(
                color: context.colors.onSurface.withValues(alpha: 0.3),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Comment Input Bar ────────────────────────────────────────────────────────

class _CommentInputBar extends StatefulWidget {
  const _CommentInputBar({
    required this.controller,
    required this.focusNode,
    required this.isFocused,
    required this.onSubmit,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final bool isFocused;
  final VoidCallback onSubmit;

  @override
  State<_CommentInputBar> createState() => _CommentInputBarState();
}

class _CommentInputBarState extends State<_CommentInputBar> {
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      final hasText = widget.controller.text.trim().isNotEmpty;
      if (hasText != _hasText) setState(() => _hasText = hasText);
    });
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;
    final safeBottom = MediaQuery.of(context).padding.bottom;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
      decoration: BoxDecoration(
        color: context.colors.surface,
        border: Border(
          top: BorderSide(
            color: widget.isFocused
                ? context.colors.primary.withValues(alpha: 0.3)
                : context.colors.outline.withValues(alpha: 0.15),
            width: widget.isFocused ? 1.5 : 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      padding: EdgeInsets.fromLTRB(
        16,
        12,
        16,
        bottomPadding > 0 ? bottomPadding + 8 : safeBottom + 12,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CircleAvatar(
            backgroundColor: context.colors.onSurface,
            child: Icon(LucideIcons.user, color: context.colors.surface),
          ),
          10.w,

          // Text field
          Expanded(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                color: context.colors.surfaceContainer,
                borderRadius: 24.circular,
                border: Border.all(
                  color: widget.isFocused
                      ? context.colors.outline
                      : Colors.transparent,
                  width: 1.5,
                ),
              ),
              child: TextField(
                controller: widget.controller,
                focusNode: widget.focusNode,
                maxLines: 4,
                minLines: 1,
                textCapitalization: TextCapitalization.sentences,
                style: context.text.bodyMedium?.copyWith(
                  color: context.colors.onSurface,
                ),
                decoration: InputDecoration(
                  hintText: context.l10n.writeComment,
                  hintStyle: context.text.bodyMedium?.copyWith(
                    color: context.colors.onSurfaceVariant,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  isDense: true,
                ),
                onSubmitted: (_) => widget.onSubmit(),
              ),
            ),
          ),
          8.w,

          // Send button
          AnimatedScale(
            scale: _hasText ? 1.0 : 0.95,
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOut,
            child: AnimatedOpacity(
              opacity: _hasText ? 1.0 : 0.4,
              duration: const Duration(milliseconds: 180),
              child: GestureDetector(
                onTap: _hasText ? widget.onSubmit : null,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: _hasText
                        ? context.colors.primaryContainer
                        : context.colors.outline.withValues(alpha: 0.3),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    LucideIcons.sendHorizontal,
                    size: 18,
                    color: _hasText
                        ? context.colors.onPrimaryContainer
                        : context.colors.onSurface.withValues(alpha: 0.4),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
