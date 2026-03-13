import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kelasqna/kelasqna.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class DashboardAppBar extends StatelessWidget {
  const DashboardAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      floating: false,
      backgroundColor: context.colors.surfaceContainer,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,
      toolbarHeight: 80,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${context.l10n.welcomeTo} KelasQNA",
            style: context.text.bodyMedium?.copyWith(
              color: context.colors.onSurfaceVariant,
            ),
          ),
          BlocSelector<SessionsBloc, SessionsState, String>(
            selector: (state) => state.maybeWhen(
              authenticated: (user, _, _) => user.name,
              orElse: () => "",
            ),
            builder: (context, userName) {
              return Text(
                userName,
                style: context.text.titleMedium?.copyWith(
                  color: context.colors.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
        ].separatedBy(4.h),
      ),
      actions: [
        NeoKelasUnavailableFeature(
          unavailableWidget: NeoKelasContainer(
            width: 40,
            height: 40,
            margin: 16.onlyRight,
            padding: EdgeInsets.zero,
            child: IconButton(
              onPressed: () {
                NeoKelasAppToast.show(
                  context,
                  message: context.l10n.featureNotYetAvailable,
                  type: ToastType.info,
                );
              },
              icon: Icon(
                LucideIcons.bell,
                color: context.colors.onSurface,
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
