import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kelasqna/kelasqna.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class QnaCardHeader extends StatelessWidget {
  const QnaCardHeader({
    super.key,
    required this.questionEntity,
    this.showTrailing = true,
  });

  final QuestionEntity questionEntity;

  /// A flag to show more action or not
  final bool showTrailing;

  @override
  Widget build(BuildContext context) {
    String displayName = questionEntity.author.name;

    /// If the user name is more than 3 words long,
    /// only the first 3 words of the name will be displayed.
    if (questionEntity.author.name.split(" ").length > 3) {
      displayName = questionEntity.author.name.split(" ").take(3).join(" ");
    }

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      visualDensity: VisualDensity.compact,
      leading: CircleAvatar(
        backgroundColor: context.colors.onSurface,
        foregroundColor: context.colors.surface,
        child: (questionEntity.author.avatar != null)
            ? CachedNetworkImage(imageUrl: questionEntity.author.avatar!)
            : Icon(LucideIcons.user),
      ),
      title: Text(
        displayName,
        style: context.text.titleMedium?.copyWith(
          color: context.colors.onSurface,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        questionEntity.author.role,
        style: context.text.labelMedium?.copyWith(
          color: context.colors.onSurfaceVariant,
        ),
      ),

      trailing:
          (showTrailing &&
              questionEntity.author.id == sI<SessionsBloc>().getUserId)
          ? PopupMenuButton<String>(
              icon: Icon(
                LucideIcons.ellipsis,
                color: context.colors.onSurfaceVariant,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: 16.circular,
                side: BorderSide(color: context.colors.outlineVariant),
              ),
              color: context.colors.surface,
              itemBuilder: (_) => [
                PopupMenuItem(
                  value: 'edit',
                  child: Row(
                    children: [
                      Icon(
                        LucideIcons.squarePen,
                        size: 16,
                        color: Colors.amber,
                      ),
                      8.w,
                      Text(
                        context.l10n.edit,
                        style: context.text.bodyMedium?.copyWith(
                          color: Colors.amber,
                        ),
                      ),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      Icon(
                        LucideIcons.trash2,
                        size: 16,
                        color: context.colors.error,
                      ),
                      8.w,
                      Text(
                        context.l10n.delete,
                        style: context.text.bodyMedium?.copyWith(
                          color: context.colors.error,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              onSelected: (value) {
                if (value == "edit") {
                  showCupertinoSheet(
                    context: context,
                    builder: (context) {
                      return Material(
                        child: SafeArea(
                          child: EditQuestionScreen(
                            questionEntity: questionEntity,
                          ),
                        ),
                      );
                    },
                  );
                }

                if (value == 'delete') {
                  NeoKelasDeleteDialog.show(
                    context,
                    title: context.l10n.deleteQuestion,
                    description: context.l10n.deleteQuestionDesc,
                    onConfirm: () {
                      context.read<DeleteQuestionBloc>().add(
                        DeleteQuestionEvent.deleteQuestion(
                          id: questionEntity.id,
                        ),
                      );
                    },
                  );
                }
              },
            )
          : null,
    );
  }
}
