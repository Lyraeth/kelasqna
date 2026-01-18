import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:kelasqna/core/internationalization/intl_label_keys.dart';
import 'package:kelasqna/core/routes/kelasqna_route.dart';
import 'package:kelasqna/core/shared/constant.dart';
import 'package:kelasqna/core/shared/widgets/neo_kelas_bottom_sheet.dart';
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

          failure: (errorMessage, detailedErrorMessage) {
            final isInvalidPassword =
                (errorMessage.contains("invalid") ||
                errorMessage.contains("password"));

            Get.bottomSheet(
              NeoKelasBottomSheet(
                height: MediaQuery.of(context).size.height * 0.4,
                onPressed: Get.back,
                buttonText: tryAgainKey,
                title: errorMessage,
                desc: isInvalidPassword
                    ? wrongPasswordDescKey
                    : wrongUsernameDescKey,
                lottieAsset: "assets/animations/failed.json",
              ),
              backgroundColor: primaryBackground,
              enableDrag: true,
              isDismissible: true,
            );
          },
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
