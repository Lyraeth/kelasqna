import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kelasqna/kelasqna.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

@RoutePage()
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with
        SingleTickerProviderStateMixin,
        AutoRouteAwareStateMixin<ProfileScreen> {
  late TabController _tabController;

  @override
  void didPopNext() {
    super.didPopNext();
    context.read<ProfileBookmarksBloc>().add(
      const ProfileBookmarksEvent.started(forceRefresh: true),
    );
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_onTabChanged);
    context.read<ProfileBookmarksBloc>().add(
      const ProfileBookmarksEvent.started(forceRefresh: true),
    );
  }

  void _onTabChanged() {
    if (_tabController.indexIsChanging) return;
    switch (_tabController.index) {
      case 0:
        context.read<ProfileBookmarksBloc>().add(
          const ProfileBookmarksEvent.started(forceRefresh: true),
        );
      case 1:
        context.read<ProfileQuestionsBloc>().add(
          const ProfileQuestionsEvent.started(forceRefresh: true),
        );
      case 2:
        context.read<ProfileCommentsBloc>().add(
          const ProfileCommentsEvent.started(),
        );
    }
  }

  @override
  void dispose() {
    _tabController
      ..removeListener(_onTabChanged)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final UserEntity? userEntity = context
        .watch<SessionsBloc>()
        .state
        .whenOrNull(authenticated: (user, _, _) => user);

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        state.whenOrNull(
          successLogout: () {
            context.read<SessionsBloc>().add(SessionsEvent.loggedOut());
          },
        );
      },
      child: Scaffold(
        backgroundColor: context.colors.surfaceContainer,
        appBar: ProfileAppBar(),
        body: Column(
          children: [
            ProfileHeader(userEntity: userEntity),
            8.h,
            Padding(
              padding: 16.horizontal,
              child: NeoKelasContainer(
                backgroundColor: context.colors.surface,
                padding: 8.all,
                child: TabBar(
                  controller: _tabController,
                  dividerColor: Colors.transparent,
                  indicator: BoxDecoration(
                    color: context.colors.onSurface,
                    borderRadius: 8.circular,
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelColor: context.colors.surface,
                  unselectedLabelColor: context.colors.onSurface,
                  labelStyle: context.text.labelMedium?.copyWith(
                    color: context.colors.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                  tabs: [
                    _buildTab(LucideIcons.bookmark, context.l10n.bookmarks),
                    _buildTab(
                      LucideIcons.messageSquare,
                      context.l10n.questions,
                    ),
                    _buildTab(LucideIcons.messageCircle, context.l10n.comments),
                  ],
                ),
              ),
            ),
            8.h,
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [BookmarksTab(), QuestionsTab(), CommentsTab()],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Tab _buildTab(IconData icon, String label) {
    return Tab(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Icon(icon, size: 14), 5.w, Text(label)],
      ),
    );
  }
}
