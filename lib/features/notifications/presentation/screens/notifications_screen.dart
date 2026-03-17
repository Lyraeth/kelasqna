import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:kelasqna/kelasqna.dart';

@RoutePage()
class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.surfaceContainer,
      appBar: AppBar(
        title: Text(
          context.l10n.notification,
          style: context.text.titleLarge?.copyWith(
            color: context.colors.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: NotificationsData(),
    );
  }
}
