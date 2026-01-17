import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:kelasqna/core/routes/kelasqna_route.dart';
import 'package:kelasqna/core/shared/constant.dart';
import 'package:kelasqna/features/auth/presentation/bloc/me/me_bloc.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  static Widget routeInstance() {
    return BlocProvider<MeBloc>.value(
      value: sI<MeBloc>(),
      child: OnBoardingScreen(),
    );
  }

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  void _getDataUser() {
    context.read<MeBloc>().add(MeEvent.getDataViaJwt());
  }

  @override
  void initState() {
    _getDataUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MeBloc, MeState>(
      listener: (context, state) {
        state.whenOrNull(
          success: (userResponse) async {
            final isAdmin =
                userResponse.userModel.role.name.toLowerCase() == "admin";

            Future.delayed(const Duration(seconds: 3), () {
              if (isAdmin) {
                Get.offNamedUntil(
                  KelasQNARoute.adminHomeScreen,
                  (route) => false,
                );
              } else {
                Get.offNamedUntil(
                  KelasQNARoute.userHomeScreen,
                  (route) => false,
                );
              }
            });
          },
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
