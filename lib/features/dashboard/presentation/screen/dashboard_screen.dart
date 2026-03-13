import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kelasqna/kelasqna.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

@RoutePage()
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => _fetchQuestions());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _fetchQuestions() {
    context.read<QuestionsBloc>().add(
      QuestionsEvent.started(forceRefresh: true),
    );
  }

  void _scrollToTop() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.surfaceContainer,
      body: QuestionsBlocListener(
        child: BlocConsumer<QuestionsBloc, QuestionsState>(
          listenWhen: (previous, current) =>
              (current.maybeWhen(
                hasData: (_, _, _) => true,
                orElse: () => false,
              ) &&
              previous.maybeWhen(loading: (_) => true, orElse: () => false)),
          listener: (context, state) => _scrollToTop(),
          builder: (context, state) {
            return NeoKelasRefreshWrapper(
              onRefresh: () async {
                context.read<QuestionsBloc>().add(
                  QuestionsEvent.started(forceRefresh: true),
                );
              },
              child: CustomScrollView(
                controller: _scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  // App bar
                  DashboardAppBar(),

                  // Content
                  state.maybeWhen(
                    loading: (_) => DashboardShimmer(),
                    emptyData: () => SliverFillRemaining(
                      child: Column(
                        children: [
                          QuestionsCreateTextField(forEmptyData: true),
                          Expanded(
                            child: NeoKelasEmptyScreen(
                              icon: LucideIcons.messageSquare,
                              message: context.l10n.emptyQuestions,
                            ),
                          ),
                        ],
                      ),
                    ),
                    hasData: (listQuestions, _, _) => SliverPadding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
                      sliver: SliverList.separated(
                        itemCount: listQuestions.length + 3,
                        separatorBuilder: (_, _) => 16.h,
                        itemBuilder: (context, index) {
                          if (index == 0) return DashboardFilterSortButton();

                          if (index == 1) {
                            return QuestionsCreateTextField();
                          }

                          if (index == listQuestions.length + 2) {
                            return DashboardPaginationButton();
                          }

                          final question = listQuestions[index - 2];

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
                    orElse: () => const SliverFillRemaining(child: SizedBox()),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
