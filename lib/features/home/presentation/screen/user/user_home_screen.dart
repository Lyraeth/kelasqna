import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:kelasqna/core/internationalization/intl_label_keys.dart';
import 'package:kelasqna/core/routes/kelasqna_route.dart';
import 'package:kelasqna/features/auth/domain/entity/user_entity.dart';
import 'package:kelasqna/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:kelasqna/utils/utils.dart';

class UserHomeScreen extends StatelessWidget {
  const UserHomeScreen({super.key});

  static Widget routeInstance() {
    return UserHomeScreen();
  }

  @override
  Widget build(BuildContext context) {
    final UserEntity? userDetails = context.read<AuthBloc>().getUserDetails;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Hello ${userDetails?.name}"),

            SizedBox(height: 48),

            FilledButton(
              onPressed: () {
                Get.offNamedUntil(KelasQNARoute.authScreen, (route) => false);
              },
              child: Text(Utils.getTranslatedLabel(logoutKey)),
            ),
          ],
        ),
      ),
    );
  }
}
