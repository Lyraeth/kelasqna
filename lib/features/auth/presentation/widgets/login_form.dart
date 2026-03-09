import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kelasqna/kelasqna.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool showPassword = true;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() {
    final loginParams = LoginRequest(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );

    context.read<AuthBloc>().add(
      AuthEvent.loginRequested(loginRequest: loginParams),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NeoKelasTextFormField(
          controller: _emailController,
          textFieldName: context.l10n.email,
          validatorString: context.l10n.requiredEmail,
          hintText: context.l10n.emailHint,
        ),
        NeoKelasTextFormField(
          controller: _passwordController,
          obscureText: showPassword,
          textFieldName: context.l10n.password,
          validatorString: context.l10n.passwordRequired,
          hintText: context.l10n.passwordHint,
          trailing: [
            GestureDetector(
              onTap: () {
                setState(() {
                  showPassword = !showPassword;
                });
              },
              child: Icon(
                showPassword ? LucideIcons.eyeClosed : LucideIcons.eye,
              ),
            ),
          ],
        ),
        BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            final isLoading = state.maybeWhen(
              loading: () => true,
              orElse: () => false,
            );

            return NeoKelasButton(
              onPressed: () => isLoading ? null : _login(),
              backgroundColor: context.colors.primaryContainer,
              child: Text(
                context.l10n.login,
                style: context.text.titleMedium?.copyWith(
                  color: context.colors.onPrimaryContainer,
                  fontWeight: FontWeight.w700,
                ),
              ),
            );
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              context.l10n.dontHaveAnAccount,
              style: context.text.labelLarge?.copyWith(
                color: context.colors.onSurfaceVariant,
              ),
            ),
            GestureDetector(
              onTap: () => context.router.replace(const RegisterRoute()),
              child: Text(
                context.l10n.register,
                style: context.text.labelLarge?.copyWith(
                  color: context.colors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ].separatedBy(4.w),
        ),
      ].separatedBy(24.h),
    );
  }
}
