import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:kelasqna/kelasqna.dart';

@RoutePage()
class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: 24.horizontal,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  context.l10n.welcomeTo,
                  style: context.text.titleLarge?.copyWith(
                    color: context.colors.onSurfaceVariant,
                  ),
                ),
                NeoKelasContainer(
                  backgroundColor: context.colors.tertiaryContainer,
                  child: Text(
                    context.l10n.kelasqna,
                    style: context.text.headlineMedium?.copyWith(
                      color: context.colors.onTertiaryContainer,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ].separatedBy(8.w),
            ),

            Column(
              children: [
                NeoKelasButton(
                  onPressed: () {},
                  backgroundColor: context.colors.secondaryContainer,
                  child: Text(
                    context.l10n.register,
                    style: context.text.bodyMedium?.copyWith(
                      color: context.colors.onSecondaryContainer,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                NeoKelasButton(
                  onPressed: () => context.router.push(const LoginRoute()),
                  backgroundColor: context.colors.primaryContainer,
                  child: Text(
                    context.l10n.login,
                    style: context.text.bodyMedium?.copyWith(
                      color: context.colors.onPrimaryContainer,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ].separatedBy(16.h),
            ),
          ].separatedBy(32.h),
        ),
      ),
    );
  }
}
