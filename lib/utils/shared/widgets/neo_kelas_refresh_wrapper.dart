import 'package:flutter/material.dart';
import 'package:kelasqna/kelasqna.dart';

class NeoKelasRefreshWrapper extends StatelessWidget {
  const NeoKelasRefreshWrapper({
    super.key,
    required this.onRefresh,
    required this.child,
  });

  final Future<void> Function() onRefresh;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      color: context.colors.primary,
      child: child,
    );
  }
}
