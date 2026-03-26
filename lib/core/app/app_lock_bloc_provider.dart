import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kelasqna/kelasqna.dart';

class AppLockBlocProvider extends StatefulWidget {
  const AppLockBlocProvider({super.key, required this.child});

  final Widget child;

  @override
  State<AppLockBlocProvider> createState() => _AppLockBlocProviderState();
}

class _AppLockBlocProviderState extends State<AppLockBlocProvider>
    with WidgetsBindingObserver {
  late final AppLockCubit _appLockCubit = sI<AppLockCubit>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
      case AppLifecycleState.hidden:
        debugPrint(state.toString());
        _appLockCubit.onAppBackground();
        break;
      case AppLifecycleState.resumed:
        debugPrint(state.toString());
        final sessionsBloc = sI<SessionsBloc>();

        final isAuthenticated = sessionsBloc.state.maybeWhen(
          authenticated: (_, _, _) => true,
          orElse: () => false,
        );

        if (isAuthenticated) {
          _appLockCubit.onAppForeground();
        }
        break;
      default:
        break;
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) => BlocProvider<AppLockCubit>.value(
    value: sI<AppLockCubit>(),
    child: widget.child,
  );
}
