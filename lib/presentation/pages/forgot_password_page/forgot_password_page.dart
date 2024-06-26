import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nonton_id/core/extension/context_ext.dart';
import 'package:nonton_id/core/extension/string_ext.dart';
import 'package:nonton_id/presentation/bloc/bloc.dart';
import 'package:nonton_id/presentation/widgets/widgets.dart';

import '../../../core/constant/color.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          child: Column(
            children: [
              verticalSpace(100),
              const AppLogo(),
              verticalSpace(70),
              TextFieldCustom(
                hint: 'Email',
                controller: _emailController,
                textInputAction: TextInputAction.done,
              ),
              verticalSpace(60),
              BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
                listener: (context, state) {
                  if (state.status == StatusForgotPassword.success) {
                    context.showSnackbar(state.message ?? '');
                    context.pop();
                  } else if (state.status == StatusForgotPassword.failed) {
                    context.showSnackbar(state.message ?? '');
                  }
                },
                builder: (context, state) {
                  return ButtonCustom(
                    title: state.status == StatusForgotPassword.loading
                        ? 'Loading...'
                        : 'Kirim',
                    onPressed: state.status == StatusForgotPassword.loading
                        ? null
                        : () => _forgotPassword(),
                  );
                },
              ),
              verticalSpace(40),
              Wrap(
                spacing: 8,
                children: [
                  Text(
                    'Sudah Punya Akun ?',
                    style: TextStyle(color: grey.withOpacity(0.8)),
                  ),
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: const Text(
                      'Masuk',
                      style: TextStyle(
                        color: primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              verticalSpace(50),
            ],
          ),
        ),
      ),
    );
  }

  _forgotPassword() {
    if (_emailController.text.isEmpty ||
        !_emailController.text.isValidEmail()) {
      context.showSnackbar('Email tidak valid');
    } else {
      FocusManager.instance.primaryFocus?.unfocus();
      context
          .read<ForgotPasswordBloc>()
          .add(OnForgotPassword(_emailController.text));
    }
  }
}
