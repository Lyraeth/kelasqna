import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:kelasqna/kelasqna.dart';

@RoutePage()
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.profile)),
      body: Center(child: Text(context.l10n.profile)),
    );
  }
}
