import 'package:flutter/material.dart';
import 'package:kelasqna/kelasqna.dart';

class NeoKelasUnavailableFeature extends StatelessWidget {
  const NeoKelasUnavailableFeature({
    super.key,
    required this.unavailableWidget,
    this.forShowOnMenuScreen = true,
  });

  final Widget unavailableWidget;

  final bool forShowOnMenuScreen;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        NeoKelasAppToast.show(
          context,
          message: context.l10n.featureNotYetAvailable,
          type: ToastType.info,
          forShowOnMenuScreen: forShowOnMenuScreen,
        );
      },
      child: unavailableWidget,
    );
  }
}
