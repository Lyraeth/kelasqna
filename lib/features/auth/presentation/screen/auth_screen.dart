import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kelasqna/core/internationalization/intl_label_keys.dart';
import 'package:kelasqna/core/routes/kelasqna_route.dart';
import 'package:kelasqna/core/shared/constant.dart';
import 'package:kelasqna/core/shared/widgets/neo_kelas_button.dart';
import 'package:kelasqna/core/shared/widgets/neo_kelas_container.dart';
import 'package:kelasqna/utils/utils.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  static Widget routeInstance() {
    return const AuthScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBackground,
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * (0.8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              NeoKelasContainer(
                containerColor: Theme.of(context).colorScheme.surface,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                child: Image.asset(
                  "assets/images/kelasqna_logo.jpeg",
                  fit: BoxFit.cover,
                ),
              ),

              SizedBox(height: 48),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  NeoKelasButton(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    buttonColor: Theme.of(context).colorScheme.primaryContainer,
                    onPressed: () => Get.toNamed(KelasQNARoute.registerScreen),
                    child: Text(
                      Utils.getTranslatedLabel(registerKey),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ),

                  NeoKelasButton(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    buttonColor: Theme.of(context).colorScheme.primary,
                    onPressed: () => Get.toNamed(KelasQNARoute.loginScreen),
                    child: Text(
                      Utils.getTranslatedLabel(loginKey),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
