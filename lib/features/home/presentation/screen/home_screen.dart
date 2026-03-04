import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kelasqna/kelasqna.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        state.whenOrNull(
          successLogout: () =>
              context.read<SessionsBloc>().add(SessionsEvent.loggedOut()),
        );
      },
      child: Scaffold(
        body: Center(
          child: BlocBuilder<SessionsBloc, SessionsState>(
            builder: (context, state) {
              return state.maybeWhen(
                authenticated: (user, accessToken, _) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("${context.l10n.name} : ${user?.name}"),
                      Text("${context.l10n.email} : ${user?.email}"),
                      Text("AccessToken : $accessToken"),
                      24.h,
                      NeoKelasButton(
                        onPressed: () {
                          context.read<AuthBloc>().add(
                            AuthEvent.logoutRequested(),
                          );
                        },
                        child: Text(context.l10n.logout),
                      ),
                    ].separatedBy(24.h),
                  );
                },
                orElse: () => SizedBox.shrink(),
              );
            },
          ),
        ),
      ),
    );
  }
}
