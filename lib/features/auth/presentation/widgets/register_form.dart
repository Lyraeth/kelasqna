import 'package:auto_route/auto_route.dart';
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

  UserRole? _selectedRole;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmedPasswordController =
      TextEditingController();
  final TextEditingController _classNameController = TextEditingController();
  final TextEditingController _classNumberController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();

  void _register() {
    final registerParams = UserRegisterParams(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      passwordConfirmation: _confirmedPasswordController.text.trim(),
      classNumber: _classNumberController.text.trim(),
      className: _classNameController.text.trim(),
      role: _selectedRole,
      subject: _subjectController.text.trim(),
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
    _classNameController.dispose();
    _classNumberController.dispose();
    _subjectController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NeoKelasTextFormField(
          controller: _nameController,
          textFieldName: context.l10n.name,
          hintText: context.l10n.nameHint,
        ),
        NeoKelasTextFormField(
          controller: _emailController,
          textFieldName: context.l10n.email,

          hintText: context.l10n.emailHint,
        ),
        NeoKelasTextFormField(
          controller: _passwordController,
          obscureText: showPassword,
          textFieldName: context.l10n.password,
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
        NeoKelasTextFormField(
          controller: _confirmedPasswordController,
          obscureText: showConfirmedPassword,
          textFieldName: context.l10n.confirmPassword,
          hintText: context.l10n.passwordHint,
          trailing: [
            GestureDetector(
              onTap: () {
                setState(() {
                  showConfirmedPassword = !showConfirmedPassword;
                });
              },
              child: Icon(
                showConfirmedPassword ? LucideIcons.eyeClosed : LucideIcons.eye,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              context.l10n.role,
              style: context.text.titleMedium?.copyWith(
                color: context.colors.onSurface,
                fontWeight: FontWeight.w700,
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  NeoKelasButton(
                    onPressed: () {
                      setState(() {
                        _selectedRole = UserRole.student;
                      });
                    },
                    padding: const EdgeInsets.symmetric(
                      vertical: 6,
                      horizontal: 12,
                    ),
                    backgroundColor: (_selectedRole == UserRole.student)
                        ? context.colors.primaryContainer
                        : null,
                    child: Text(
                      UserRole.student.name,
                      style: TextStyle(
                        color: (_selectedRole == UserRole.student)
                            ? context.colors.onPrimaryContainer
                            : null,
                      ),
                    ),
                  ),
                  NeoKelasButton(
                    onPressed: () {
                      setState(() {
                        _selectedRole = UserRole.teacher;
                      });
                    },
                    padding: const EdgeInsets.symmetric(
                      vertical: 6,
                      horizontal: 12,
                    ),
                    backgroundColor: (_selectedRole == UserRole.teacher)
                        ? context.colors.primaryContainer
                        : null,
                    child: Text(
                      UserRole.teacher.name,
                      style: TextStyle(
                        color: (_selectedRole == UserRole.teacher)
                            ? context.colors.onPrimaryContainer
                            : null,
                      ),
                    ),
                  ),
                ].separatedBy(16.w),
              ),
            ),
          ],
        ),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) {
            return FadeTransition(opacity: animation, child: child);
          },
          child: _selectedRole == UserRole.student
              ? Row(
                  key: ValueKey(UserRole.student.name),
                  children: [
                    Expanded(
                      child: NeoKelasTextFormField(
                        controller: _classNameController,
                        textFieldName: context.l10n.className,
                        hintText: context.l10n.classNameHint,
                      ),
                    ),
                    Expanded(
                      child: NeoKelasTextFormField(
                        controller: _classNumberController,
                        textFieldName: context.l10n.classNumber,
                        hintText: context.l10n.classNumberHint,
                      ),
                    ),
                  ].separatedBy(16.w),
                )
              : _selectedRole == UserRole.teacher
              ? NeoKelasTextFormField(
                  key: ValueKey(UserRole.teacher.name),
                  controller: _subjectController,
                  textFieldName: context.l10n.subject,
                  hintText: context.l10n.subjectHint,
                )
              : const SizedBox.shrink(key: ValueKey('empty')),
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              context.l10n.alreadyHaveAnAccount,
              style: context.text.labelLarge?.copyWith(
                color: context.colors.onSurfaceVariant,
              ),
            ),
            GestureDetector(
              onTap: () => context.router.replace(const LoginRoute()),
              child: Text(
                context.l10n.login,
                style: context.text.labelLarge?.copyWith(
                  color: context.colors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ].separatedBy(4.w),
        ),
      ].separatedBy(16.h),
    );
  }
}
