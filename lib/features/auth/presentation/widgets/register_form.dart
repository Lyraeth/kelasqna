import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kelasqna/core/internationalization/intl_label_keys.dart';
import 'package:kelasqna/core/shared/constant.dart';
import 'package:kelasqna/core/shared/widgets/neo_kelas_button.dart';
import 'package:kelasqna/core/shared/widgets/neo_kelas_text_form_field.dart';
import 'package:kelasqna/features/auth/presentation/bloc/register/register_bloc.dart';
import 'package:kelasqna/utils/utils.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  bool showPassword = true;
  bool showConfirmPassword = true;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  void _registerUser({
    required String name,
    required String username,
    required String password,
  }) async {
    context.read<RegisterBloc>().add(
      RegisterEvent.register(
        name: name,
        username: username,
        password: password,
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Utils.getTranslatedLabel(registerKey),
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
              fontWeight: FontWeight.w700,
            ),
          ),

          SizedBox(height: 8),

          Divider(
            thickness: 3,
            color: Theme.of(context).colorScheme.outline,
            radius: BorderRadius.circular(8),
          ),

          SizedBox(height: 24),

          NeoKelasTextFormField(
            controller: _nameController,
            textFieldName: nameKey,
            validatorString: nameRequiredKey,
          ),

          SizedBox(height: 24),

          NeoKelasTextFormField(
            controller: _usernameController,
            textFieldName: usernameKey,
            validatorString: usernameRequiredKey,
          ),

          SizedBox(height: 24),

          NeoKelasTextFormField(
            controller: _passwordController,
            textFieldName: passwordKey,
            obscureText: showPassword,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return Utils.getTranslatedLabel(passwordRequiredKey);
              }

              if (value.length < 6) {
                return Utils.getTranslatedLabel(passwordRequiredLengthKey);
              }

              return null;
            },
            trailing: [
              IconButton(
                onPressed: () {
                  setState(() {
                    showPassword = !showPassword;
                  });
                },
                icon: Icon(showPassword ? LucideIcons.eye : LucideIcons.eyeOff),
              ),
            ],
          ),

          SizedBox(height: 24),

          NeoKelasTextFormField(
            controller: _confirmPasswordController,
            textFieldName: confirmPasswordKey,
            obscureText: showConfirmPassword,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return Utils.getTranslatedLabel(passwordRequiredKey);
              }

              if (value.length < 6) {
                return Utils.getTranslatedLabel(passwordRequiredLengthKey);
              }

              if (value.trim() != _passwordController.text.trim()) {
                return Utils.getTranslatedLabel(confirmPasswordNotSameKey);
              }

              return null;
            },
            trailing: [
              IconButton(
                onPressed: () {
                  setState(() {
                    showConfirmPassword = !showConfirmPassword;
                  });
                },
                icon: Icon(
                  showConfirmPassword ? LucideIcons.eye : LucideIcons.eyeOff,
                ),
              ),
            ],
          ),

          SizedBox(height: 48),

          BlocBuilder<RegisterBloc, RegisterState>(
            builder: (context, state) {
              final isLoading = state.maybeWhen(
                loading: () => true,
                orElse: () => false,
              );

              return NeoKelasButton(
                padding: const EdgeInsets.symmetric(vertical: 8),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _registerUser(
                      name: _nameController.text.trim(),
                      username: _usernameController.text.trim(),
                      password: _passwordController.text.trim(),
                    );
                  }
                },
                buttonColor: primaryBlue,
                child: isLoading
                    ? CircularProgressIndicator(
                        color: Theme.of(context).colorScheme.surface,
                      )
                    : Text(
                        Utils.getTranslatedLabel(registerKey),
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
              );
            },
          ),

          SizedBox(height: 24),
        ],
      ),
    );
  }
}
