import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kelasqna/kelasqna.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => RegisterFormState();
}

class RegisterFormState extends State<RegisterForm> {
  bool showPassword = true;
  bool showConfirmedPassword = true;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmedPasswordController =
      TextEditingController();

  void _register() {
    final registerParams = UserRegisterParams(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      passwordConfirmation: _confirmedPasswordController.text.trim(),
    );

    context.read<UserBloc>().add(
      UserEvent.register(userRegisterParams: registerParams),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmedPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        state.whenOrNull(
          failure: (failure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(failure.message(context))));
          },
        );
      },
      child: Column(
        children: [
          NeoKelasTextFormField(
            controller: _nameController,
            textFieldName: context.l10n.name,
            validatorString: context.l10n.nameRequired,
          ),
          NeoKelasTextFormField(
            controller: _emailController,
            textFieldName: context.l10n.email,
            validatorString: context.l10n.requiredEmail,
          ),
          NeoKelasTextFormField(
            controller: _passwordController,
            obscureText: showPassword,
            textFieldName: context.l10n.password,
            validatorString: context.l10n.passwordRequired,
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
          NeoKelasTextFormField(
            controller: _confirmedPasswordController,
            obscureText: showConfirmedPassword,
            textFieldName: context.l10n.confirmPassword,
            validator: (value) {
              if (_confirmedPasswordController.text.trim() !=
                  _passwordController.text.trim()) {
                return context.l10n.confirmPasswordNotSame;
              }

              return null;
            },
            trailing: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    showConfirmedPassword = !showConfirmedPassword;
                  });
                },
                child: Icon(
                  showConfirmedPassword
                      ? LucideIcons.eyeClosed
                      : LucideIcons.eye,
                ),
              ),
            ],
          ),
          8.h,
          BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              final isLoading = state.maybeWhen(
                loading: () => true,
                orElse: () => false,
              );

              return NeoKelasButton(
                onPressed: () {
                  if (isLoading) return;

                  FocusScope.of(context).unfocus();

                  _register();
                },
                backgroundColor: context.colors.primaryContainer,
                child: isLoading
                    ? CircularProgressIndicator()
                    : Text(
                        context.l10n.register,
                        style: context.text.titleMedium?.copyWith(
                          color: context.colors.onPrimaryContainer,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
              );
            },
          ),
        ].separatedBy(24.h),
      ),
    );
  }
}
