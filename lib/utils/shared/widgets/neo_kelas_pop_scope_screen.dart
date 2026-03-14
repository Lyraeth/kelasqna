import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:kelasqna/kelasqna.dart';

class NeoKelasPopScopeScreen extends StatefulWidget {
  const NeoKelasPopScopeScreen({
    super.key,
    required this.autoTabsRouter,
    required this.child,
    this.onPopText,
  });

  final TabsRouter autoTabsRouter;

  final Widget child;

  final String? onPopText;

  @override
  State<NeoKelasPopScopeScreen> createState() => _NeoKelasPopScopeScreenState();
}

class _NeoKelasPopScopeScreenState extends State<NeoKelasPopScopeScreen> {
  bool canPop = false;

  void _onWillPop() {
    setState(() {
      canPop = true;
    });

    NeoKelasAppToast.show(
      context,
      message: widget.onPopText ?? context.l10n.didPopDesc,
      type: ToastType.warning,
      forShowOnMenuScreen: true,
    );

    Future.delayed(2.seconds, () {
      setState(() {
        canPop = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: canPop,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;

        if (widget.autoTabsRouter.activeIndex !=
            widget.autoTabsRouter.homeIndex) {
          widget.autoTabsRouter.setActiveIndex(0);
          return;
        }

        if (widget.autoTabsRouter.activeIndex ==
            widget.autoTabsRouter.homeIndex) {
          _onWillPop();
        }
      },
      child: widget.child,
    );
  }
}
