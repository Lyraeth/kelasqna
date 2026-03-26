import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kelasqna/kelasqna.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class AppLockScreen extends StatefulWidget {
  const AppLockScreen({super.key});

  @override
  State<AppLockScreen> createState() => _AppLockScreenState();
}

class _AppLockScreenState extends State<AppLockScreen> {
  bool _isAuthenticating = false;

  Future<void> _authenticate() async {
    if (_isAuthenticating) return;
    setState(() => _isAuthenticating = true);

    final biometric = sI<BiometricService>();
    final success = await biometric.authenticate();

    if (!mounted) return;
    setState(() => _isAuthenticating = false);

    if (success) {
      context.read<AppLockCubit>().unlock();
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => _authenticate());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.surfaceContainer,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              NeoKelasContainer(
                child: Icon(
                  LucideIcons.lockKeyhole,
                  size: 40,
                  color: context.colors.onSurface,
                ),
              ),
              24.h,
              Text(
                context.l10n.lockedKelasQNA,
                style: context.text.titleLarge?.copyWith(
                  color: context.colors.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
              16.h,
              Text(
                context.l10n.authenticateToUnlock,
                style: context.text.bodyMedium?.copyWith(
                  color: context.colors.onSurfaceVariant,
                ),
              ),
              34.h,
              _isAuthenticating
                  ? const CircularProgressIndicator()
                  : NeoKelasButton(
                      margin: 16.horizontal,
                      backgroundColor: context.colors.onSurface,
                      onPressed: () => _authenticate(),
                      child: Text(
                        context.l10n.unlockWithBiometric,
                        style: context.text.bodyMedium?.copyWith(
                          color: context.colors.surface,
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
