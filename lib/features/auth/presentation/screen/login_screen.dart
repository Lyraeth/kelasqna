import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kelasqna/kelasqna.dart';

@RoutePage()
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        state.whenOrNull(
          successLogin: (accessToken, expiresAt) {
            context.read<SessionsBloc>().add(
              SessionsEvent.loggedIn(token: accessToken),
            );
          },
          failure: (failure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(failure.message(context))));
          },
        );
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: 24.all,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                24.h,
                Text(
                  context.l10n.welcomeBack,
                  style: context.text.headlineLarge?.copyWith(
                    color: context.colors.onSurface,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                LoginForm(),
              ].separatedBy(24.h),
            ),
          ),
        ),
      ),
    );
  }
}
