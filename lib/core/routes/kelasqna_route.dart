import 'package:get/get.dart';
import 'package:kelasqna/features/auth/presentation/screen/auth_screen.dart';
import 'package:kelasqna/features/auth/presentation/screen/login_screen.dart';
import 'package:kelasqna/features/auth/presentation/screen/register_screen.dart';
import 'package:kelasqna/features/home/presentation/screen/admin/admin_home_screen.dart';
import 'package:kelasqna/features/home/presentation/screen/user/user_home_screen.dart';
import 'package:kelasqna/features/on_boarding/presentation/screen/on_boarding_screen.dart';

class KelasQNARoute {
  static const String authScreen = "/authScreen";
  static const String loginScreen = "/loginScreen";
  static const String registerScreen = "/registerScreen";
  static const String onBoardingScreen = "/onBoardingScreen";
  static const String adminHomeScreen = "/adminHomeScreen";
  static const String userHomeScreen = "/userHomeScreen";

  static List<GetPage> getPages = [
    // Auth
    GetPage(name: authScreen, page: AuthScreen.routeInstance),
    GetPage(name: loginScreen, page: LoginScreen.routeInstance),
    GetPage(name: registerScreen, page: RegisterScreen.routeInstance),

    // Onboarding
    GetPage(name: onBoardingScreen, page: OnBoardingScreen.routeInstance),

    // Home
    GetPage(name: adminHomeScreen, page: AdminHomeScreen.routeInstance),
    GetPage(name: userHomeScreen, page: UserHomeScreen.routeInstance),
  ];
}
