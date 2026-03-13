import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kelasqna/kelasqna.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class CommentsTab extends StatelessWidget {
  const CommentsTab({super.key});

  Future<void> _onRefresh(BuildContext context) async {
    context.read<ProfileCommentsBloc>().add(
      const ProfileCommentsEvent.started(forceRefresh: true),
    );
    await context.read<ProfileCommentsBloc>().stream.firstWhere(
      (s) => s.maybeWhen(loading: (_) => false, orElse: () => true),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCommentsBloc, ProfileCommentsState>(
      builder: (context, state) {
        return NeoKelasRefreshWrapper(
          onRefresh: () => _onRefresh(context),
          child: state.when(
            initial: () => const SizedBox.shrink(),
            loading: (_) => const Center(child: CircularProgressIndicator()),
            emptyData: () => NeoKelasEmptyScreen(
              icon: LucideIcons.messageCircle,
              message: context.l10n.emptyComments,
            ),
            hasData: (listComments, currentPage, totalPages) =>
                ProfilePagesList(
                  currentPage: currentPage,
                  totalPages: totalPages,
                  onPageChanged: (page) => context
                      .read<ProfileCommentsBloc>()
                      .add(ProfileCommentsEvent.loadPage(page)),
                  itemCount: listComments.length,
                  itemBuilder: (index) =>
                      _CommentCard(comment: listComments[index]),
                ),
            failure: (failure) => NeoKelasErrorScreen(
              message: failure.message(context),
              onRetry: () => context.read<ProfileCommentsBloc>().add(
                const ProfileCommentsEvent.started(forceRefresh: true),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _CommentCard extends StatelessWidget {
  final CommentsEntity comment;

  const _CommentCard({required this.comment});

  @override
  Widget build(BuildContext context) {
    return NeoKelasContainer(
      padding: 16.all,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            comment.content,
            style: context.text.bodySmall?.copyWith(
              color: context.colors.onSurface,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          Row(
            children: [
              Icon(
                LucideIcons.clock,
                size: 14,
                color: context.colors.onSurfaceVariant,
              ),
              Text(
                comment.createdAt,
                style: context.text.labelSmall?.copyWith(
                  color: context.colors.onSurfaceVariant,
                ),
              ),
            ].separatedBy(8.w),
          ),
        ].separatedBy(16.h),
      ),
    );
  }
}
