import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kelasqna/kelasqna.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class ProfileSheet extends StatefulWidget {
  const ProfileSheet({super.key, required this.userId});

  final int userId;

  @override
  State<ProfileSheet> createState() => _ProfileSheetState();
}

class _ProfileSheetState extends State<ProfileSheet>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 1, vsync: this);
    _tabController.addListener(_onTabChanged);
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _fetchUserAndQuestion(),
    );
  }

  void _onTabChanged() {
    if (_tabController.indexIsChanging) return;
    switch (_tabController.index) {
      case 0:
        context.read<ProfileQuestionsBloc>().add(
          ProfileQuestionsEvent.started(
            userId: widget.userId,
            forceRefresh: true,
          ),
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

  void _fetchUserAndQuestion() {
    context.read<UserBloc>().add(UserEvent.fetchAnotherUser(id: widget.userId));

    context.read<ProfileQuestionsBloc>().add(
      ProfileQuestionsEvent.started(userId: widget.userId, forceRefresh: true),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return state.maybeWhen(
          loading: () => Center(child: CircularProgressIndicator()),
          success: (userEntity) {
            return Column(
              children: [
                16.h,
                ProfileHeader(userEntity: userEntity),
                16.h,
                Padding(
                  padding: 16.horizontal,
                  child: NeoKelasContainer(
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
                        _buildTab(
                          LucideIcons.messageSquare,
                          context.l10n.questions,
                        ),
                      ],
                    ),
                  ),
                ),
                8.h,
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [QuestionsTab(userId: widget.userId)],
                  ),
                ),
              ],
            );
          },
          orElse: () => SizedBox.shrink(),
        );
      },
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
