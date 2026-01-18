import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kelasqna/core/internationalization/intl_label_keys.dart';
import 'package:kelasqna/core/shared/constant.dart';
import 'package:kelasqna/core/shared/widgets/neo_kelas_button.dart';
import 'package:kelasqna/core/shared/widgets/neo_kelas_check_box.dart';
import 'package:kelasqna/core/shared/widgets/neo_kelas_text_form_field.dart';
import 'package:kelasqna/features/auth/presentation/bloc/sign_in/sign_in_bloc.dart';
import 'package:kelasqna/utils/utils.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  bool showPassword = true;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _signIn({required String username, required String password}) async {
    context.read<SignInBloc>().add(
      SignInEvent.login(username: username, password: password),
    );
  }

  @override
  void initState() {
    super.initState();
    context.read<SignInBloc>().add(const SignInEvent.started());
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUnfocus,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Utils.getTranslatedLabel(loginKey),
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

          BlocListener<SignInBloc, SignInState>(
            listenWhen: (prev, curr) =>
                curr.maybeWhen(
                  initial: (isRemembered, rememberedUsername) => true,
                  orElse: () => false,
                ) &&
                curr.maybeWhen(
                  initial: (isRemembered, rememberedUsername) =>
                      rememberedUsername != null,
                  orElse: () => false,
                ),
            listener: (context, state) {
              state.maybeWhen(
                initial: (_, username) {
                  if (username != null) {
                    _usernameController.text = username;
                  }
                },
                orElse: () {},
              );
            },
            child: NeoKelasTextFormField(
              controller: _usernameController,
              textFieldName: usernameKey,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return Utils.getTranslatedLabel(usernameRequiredKey);
                }

                return null;
              },
            ),
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

          BlocBuilder<SignInBloc, SignInState>(
            builder: (context, state) {
              final isChecked = state.maybeWhen(
                initial: (isRemembered, rememberedUsername) => isRemembered,
                loading: (isRemembered, rememberedUsername) => isRemembered,
                orElse: () => false,
              );

              return NeoKelasCheckBox(
                width: 23,
                height: 23,
                value: isChecked,
                onChanged: (value) {
                  context.read<SignInBloc>().add(
                    SignInEvent.rememberMeChanged(
                      value: value ?? false,
                      username: _usernameController.text,
                    ),
                  );
                },
                checkBoxTitle: rememberMeKey,
              );
            },
          ),

          SizedBox(height: 24),

          BlocBuilder<SignInBloc, SignInState>(
            builder: (context, state) {
              final isLoading = state.maybeWhen(
                loading: (isRemembered, rememberedUsername) => true,
                orElse: () => false,
              );

              return NeoKelasButton(
                padding: const EdgeInsets.symmetric(vertical: 8),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _signIn(
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
                        Utils.getTranslatedLabel(loginKey),
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
