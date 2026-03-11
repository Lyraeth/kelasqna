import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kelasqna/kelasqna.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

@RoutePage()
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.surfaceContainer,
      body: QuestionsBlocListener(
        child: BlocBuilder<QuestionsBloc, QuestionsState>(
          builder: (context, state) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<QuestionsBloc>().add(
                  QuestionsEvent.started(forceRefresh: true),
                );
              },
              child: CustomScrollView(
                slivers: [
                  // App bar
                  DashboardAppBar(),

                  // Content
                  state.maybeWhen(
                    loading: () => DashboardShimmer(),
                    emptyData: () => SliverFillRemaining(
                      child: Center(
                        child: Text(
                          context.l10n.emptyQuestions,
                          style: context.text.titleMedium?.copyWith(
                            color: context.colors.onSurface,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    hasData: (listQuestions) => SliverPadding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
                      sliver: SliverList.separated(
                        itemCount: listQuestions.length + 1,
                        separatorBuilder: (_, _) => 16.h,
                        itemBuilder: (context, index) {
                          if (index == 0) return DashboardFilterSortButton();

                          final question = listQuestions[index - 1];

                          return QuestionDismissible(
                            questionEntity: question,
                            child: DashboardQnaCard(
                              questionEntity: question,
                              onTap: () {
                                showCupertinoSheet(
                                  context: context,
                                  builder: (context) => Material(
                                    child: SafeArea(
                                      child: QnaDetailScreen(
                                        questionEntity: question,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    orElse: () => const SliverToBoxAdapter(child: SizedBox()),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: NeoKelasButton(
        width: 50,
        height: 50,
        backgroundColor: context.colors.primaryContainer,
        padding: EdgeInsets.zero,
        onPressed: () async {
          showCupertinoSheet(
            context: context,
            builder: (context) =>
                Material(child: SafeArea(child: CreateQuestionScreen())),
          );
        },
        child: Icon(LucideIcons.plus, color: context.colors.onPrimaryContainer),
      ),
    );
  }
}
