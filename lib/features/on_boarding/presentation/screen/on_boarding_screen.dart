import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kelasqna/kelasqna.dart';

@RoutePage()
class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SessionsBloc, SessionsState>(
      listener: (context, state) {
        state.whenOrNull(
          authenticated: (user, accessToken) =>
              context.router.replaceAll([const HomeRoute()]),
        );
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),

              SizedBox(height: 48),

              Text("Getting your data"),
            ],
          ),
        ),
      ),
    );
  }
}
