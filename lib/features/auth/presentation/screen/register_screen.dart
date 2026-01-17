import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:kelasqna/core/internationalization/intl_label_keys.dart';
import 'package:kelasqna/core/routes/kelasqna_route.dart';
import 'package:kelasqna/core/shared/constant.dart';
import 'package:kelasqna/core/shared/widgets/neo_kelas_bottom_sheet.dart';
import 'package:kelasqna/features/auth/presentation/bloc/register/register_bloc.dart';
import 'package:kelasqna/features/auth/presentation/widgets/register_form.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  static Widget routeInstance() {
    return BlocProvider<RegisterBloc>.value(
      value: sI<RegisterBloc>(),
      child: RegisterScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        state.whenOrNull(
          success: (registerResponse) {
            if (!Get.isBottomSheetOpen!) {
              Get.bottomSheet(
                PopScope(
                  canPop: false,
                  onPopInvokedWithResult: (didPop, _) {
                    if (!didPop) {
                      Get.back();
                      Get.offAndToNamed(KelasQNARoute.loginScreen);
                    }
                  },
                  child: NeoKelasBottomSheet(
                    onPressed: () {
                      Get.back();
                      Get.offAndToNamed(KelasQNARoute.loginScreen);
                    },
                    title: registerSuccessKey,
                    desc: registerSuccessDescKey,
                    lottieAsset: "assets/animations/check-success.json",
                    buttonText: goToLoginScreenKey,
                    useIcon: true,
                    icon: LucideIcons.chevronRight,
                  ),
                ),
                backgroundColor: primaryBackground,
                enableDrag: false,
                isDismissible: false,
              );
            }
          },
        );
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: primaryBackground,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: RegisterForm(),
          ),
        ),
      ),
    );
  }
}
