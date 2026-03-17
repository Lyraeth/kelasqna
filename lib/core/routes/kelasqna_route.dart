import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:kelasqna/kelasqna.dart';

part 'kelasqna_route.gr.dart';

@AutoRouterConfig()
class KelasQNARouter extends RootStackRouter {
  final AuthGuard _authGuard;

  KelasQNARouter(this._authGuard);

  @override
  RouteType get defaultRouteType => RouteType.cupertino();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SplashRoute.page, initial: true),
    AutoRoute(page: AuthRoute.page),
    AutoRoute(page: LoginRoute.page),
    AutoRoute(page: RegisterRoute.page),
    AutoRoute(page: OnBoardingRoute.page),

    AutoRoute(
      page: HomeRoute.page,
      guards: [_authGuard],
      children: [
        AutoRoute(page: DashboardRoute.page),
        AutoRoute(page: ProfileRoute.page),
        AutoRoute(page: SettingsRoute.page),
        AutoRoute(page: QnaDetailRoute.page),
        AutoRoute(page: NotificationsRoute.page),
      ],
    ),
  ];
}
