import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kelasqna/kelasqna.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class BookmarksTab extends StatelessWidget {
  const BookmarksTab({super.key});

  Future<void> _onRefresh(BuildContext context) async {
    context.read<ProfileBookmarksBloc>().add(
      const ProfileBookmarksEvent.started(forceRefresh: true),
    );
    await context.read<ProfileBookmarksBloc>().stream.firstWhere(
      (s) => s.maybeWhen(loading: (_) => false, orElse: () => true),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBookmarksBloc, ProfileBookmarksState>(
      builder: (context, state) {
        return NeoKelasRefreshWrapper(
          onRefresh: () => _onRefresh(context),
          child: state.when(
            initial: () => const SizedBox.shrink(),
            loading: (_) => const Center(child: CircularProgressIndicator()),
            emptyData: () => NeoKelasEmptyScreen(
              icon: LucideIcons.bookmark,
              message: context.l10n.emptyBookmarks,
            ),
            hasData: (listBookmarks, currentPage, totalPages) =>
                ProfilePagesList(
                  currentPage: currentPage,
                  totalPages: totalPages,
                  onPageChanged: (page) => context
                      .read<ProfileBookmarksBloc>()
                      .add(ProfileBookmarksEvent.loadPage(page)),
                  itemCount: listBookmarks.length,
                  itemBuilder: (index) =>
                      ProfileQuestionCard(questionEntity: listBookmarks[index]),
                ),
            failure: (failure) => NeoKelasErrorScreen(
              message: failure.message(context),
              onRetry: () => context.read<ProfileBookmarksBloc>().add(
                const ProfileBookmarksEvent.started(forceRefresh: true),
              ),
            ),
          ),
        );
      },
    );
  }
}
