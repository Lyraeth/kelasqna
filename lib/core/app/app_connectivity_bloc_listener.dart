import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kelasqna/kelasqna.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class AppConnectivityBlocListener extends StatelessWidget {
  const AppConnectivityBlocListener({
    super.key,
    required this.child,
    required this.appRouter,
  });

  final Widget child;

  final KelasQNARouter appRouter;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ConnectivityBloc, ConnectivityState>(
      listenWhen: (prev, curr) =>
          prev.connectivityStatus != curr.connectivityStatus &&
          curr.connectivityStatus != ConnectivityStatus.unknown,
      listener: (context, state) {
        final overlayState = appRouter.navigatorKey.currentState?.overlay;
        if (overlayState == null || !overlayState.mounted) return;

        final ctx = appRouter.navigatorKey.currentContext;
        if (ctx == null) return;

        final isOnMenuScreen = appRouter.current.name == HomeRoute.name;

        NeoKelasAppToast.show(
          ctx,
          overlayState: overlayState,
          message: state.isConnected
              ? ctx.l10n.connectivityConnected
              : ctx.l10n.connectivityDisconnected,
          customIcon: state.isConnected
              ? LucideIcons.wifi
              : LucideIcons.wifiOff,
          type: state.isConnected ? ToastType.info : ToastType.error,
          duration: state.isConnected ? 5.seconds : 15.seconds,
          forShowOnMenuScreen: isOnMenuScreen,
        );
      },
      child: child,
    );
  }
}
