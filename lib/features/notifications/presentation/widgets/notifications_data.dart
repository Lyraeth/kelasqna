import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kelasqna/kelasqna.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class NotificationsData extends StatefulWidget {
  const NotificationsData({super.key});

  @override
  State<NotificationsData> createState() => _NotificationsDataState();
}

class _NotificationsDataState extends State<NotificationsData> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => _fetchNotifications());
    super.initState();
  }

  void _fetchNotifications() {
    context.read<NotificationBloc>().add(
      NotificationEvent.started(forceRefresh: true),
    );
  }

  void _markAllRead() {
    context.read<NotificationBloc>().add(const NotificationEvent.markAllRead());
  }

  void _onTapNotification(
    BuildContext context,
    NotificationEntity notification,
  ) {
    if (!notification.isRead) {
      context.read<NotificationBloc>().add(
        NotificationEvent.markAsRead(id: notification.id),
      );
    }

    final questionId = notification.data['question_id'];

    if (questionId == null) return;

    Navigator.of(context).push(
      CupertinoPageRoute(
        builder: (context) =>
            FetchAndShowQuestionScreen(questionId: questionId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationBloc, NotificationState>(
      builder: (context, state) {
        return state.maybeWhen(
          hasData: (listNotification, currentPage, totalPages) {
            final hasUnread = listNotification.any((n) => n.isRead != true);

            return Column(
              children: [
                // Mark all read button
                if (hasUnread)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: _markAllRead,
                          child: Text(
                            context.l10n.markAllAsRead,
                            style: context.text.bodySmall?.copyWith(
                              color: context.colors.onSurface,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                // List
                Expanded(
                  child: ListView.separated(
                    padding: 16.all,
                    itemCount: listNotification.length,
                    separatorBuilder: (_, _) => 16.h,
                    itemBuilder: (context, index) {
                      final notification = listNotification[index];

                      return NotificationTile(
                        notification: notification,
                        onTap: () => _onTapNotification(context, notification),
                      );
                    },
                  ),
                ),
              ],
            );
          },
          emptyData: () => NeoKelasEmptyScreen(
            icon: LucideIcons.bell,
            message: context.l10n.emptyNotification,
          ),
          loading: (_) => const Center(child: CircularProgressIndicator()),
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }
}
