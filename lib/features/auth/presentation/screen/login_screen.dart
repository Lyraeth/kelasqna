import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:kelasqna/core/routes/kelasqna_route.dart';
import 'package:kelasqna/core/shared/constant.dart';
import 'package:kelasqna/features/auth/presentation/bloc/sign_in/sign_in_bloc.dart';
import 'package:kelasqna/features/auth/presentation/widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static Widget routeInstance() {
    return BlocProvider<SignInBloc>.value(
      value: sI<SignInBloc>(),
      child: LoginScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInBloc, SignInState>(
      listener: (context, state) {
        state.whenOrNull(
          success: () => Get.offNamedUntil(
            KelasQNARoute.onBoardingScreen,
            (route) => false,
          ),
        );
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: secondaryBackground,
        body: SafeArea(
          child: Padding(padding: const EdgeInsets.all(24), child: LoginForm()),
        ),
      ),
    );
  }
}
