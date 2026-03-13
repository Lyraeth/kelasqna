import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kelasqna/kelasqna.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class QuestionsTab extends StatelessWidget {
  const QuestionsTab({super.key, this.userId});

  final int? userId;

  Future<void> _onRefresh(BuildContext context) async {
    context.read<ProfileQuestionsBloc>().add(
      ProfileQuestionsEvent.started(forceRefresh: true, userId: userId),
    );
    await context.read<ProfileQuestionsBloc>().stream.firstWhere(
      (s) => s.maybeWhen(loading: (_) => false, orElse: () => true),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileQuestionsBloc, ProfileQuestionsState>(
      builder: (context, state) {
        return NeoKelasRefreshWrapper(
          onRefresh: () => _onRefresh(context),
          child: state.when(
            initial: () => const SizedBox.shrink(),
            loading: (_) => const Center(child: CircularProgressIndicator()),
            emptyData: () => NeoKelasEmptyScreen(
              icon: LucideIcons.messageSquare,
              message: context.l10n.emptyQuestions,
            ),
            hasData: (listQuestions, currentPage, totalPages) =>
                ProfilePagesList(
                  currentPage: currentPage,
                  totalPages: totalPages,
                  onPageChanged: (page) => context
                      .read<ProfileQuestionsBloc>()
                      .add(ProfileQuestionsEvent.loadPage(page)),
                  itemCount: listQuestions.length,
                  itemBuilder: (index) =>
                      ProfileQuestionCard(questionEntity: listQuestions[index]),
                ),
            failure: (failure) => NeoKelasErrorScreen(
              message: failure.message(context),
              onRetry: () => context.read<ProfileQuestionsBloc>().add(
                const ProfileQuestionsEvent.started(forceRefresh: true),
              ),
            ),
          ),
        );
      },
    );
  }
}
