import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kelasqna/kelasqna.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

@RoutePage()
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        state.whenOrNull(
          successLogout: () {
            context.read<SessionsBloc>().add(SessionsEvent.loggedOut());
          },
        );
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          title: Text(context.l10n.profile),
          actions: [
            NeoKelasContainer(
              width: 40,
              height: 40,
              margin: 16.onlyRight,
              padding: EdgeInsets.zero,
              child: IconButton(
                onPressed: () =>
                    context.read<AuthBloc>().add(AuthEvent.logoutRequested()),
                icon: Icon(
                  LucideIcons.logOut,
                  color: context.colors.onSurface,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
        body: Center(child: Text(context.l10n.profile)),
      ),
    );
  }
}
