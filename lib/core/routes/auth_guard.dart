import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:kelasqna/kelasqna.dart';

class AuthGuard extends AutoRouteGuard {
  final SessionsRepository _sessionsRepository;

  const AuthGuard(this._sessionsRepository);

  @override
  FutureOr<void> onNavigation(
    NavigationResolver resolver,
    StackRouter router,
  ) async {
    final isLoggedIn = await _sessionsRepository.isLoggedIn();

    if (isLoggedIn) {
      resolver.next(true);
    } else {
      router.replaceAll([const LoginRoute()]);
    }
  }
}
