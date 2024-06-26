import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constant/color.dart';
import '../../../core/extension/context_ext.dart';
import '../../../core/extension/string_ext.dart';
import '../../bloc/bloc.dart';
import '../../widgets/widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
              ),
              verticalSpace(20),
              TextFieldCustom(
                hint: 'Password',
                controller: _passwordController,
                obscureText: true,
                textInputAction: TextInputAction.done,
              ),
              verticalSpace(25),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () => context.pushNamed('forgot-password'),
                  child: const Text(
                    'Lupa Password ? ',
                    style: TextStyle(
                      color: primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              verticalSpace(60),
              BlocConsumer<LoginBloc, LoginState>(
                listener: (context, state) {
                  if (state.status == StatusLogin.success) {
                    // Jika status success maka ke Home Page
                    context.pushReplacementNamed('home');
                  } else if (state.status == StatusLogin.failed) {
                    if (state.message == 'Anda belum verifikasi email') {
                      /* 
                        Jika User sudah terdapat tapi belum melakukan verifikasi email
                        maka akan show dialog untuk mengirimkan ulang verifikasi email
                      */
                      context.showDialogVerification(
                        title: 'Verification Email',
                        content:
                            'Anda belum melakukan verifikasi email, apakah anda ingin dikirimkan ulang email verifikasi ?',
                        onConfirm: BlocListener<SendVerificationEmailBloc,
                            SendVerificationEmailState>(
                          listener: (context, state) {
                            if (state.status ==
                                StatusSendVerification.success) {
                              context.pop();
                              context.showSnackbar(state.message ?? '');
                            } else if (state.status ==
                                StatusSendVerification.failed) {
                              context.pop();
                              context.showSnackbar(state.message ?? '');
                            }
                          },
                          child: GestureDetector(
                            onTap: () => context
                                .read<SendVerificationEmailBloc>()
                                .add(OnSendVerificationEmail()),
                            child: const Text(
                              'Ya',
                              style: TextStyle(
                                color: primary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        onCancel: GestureDetector(
                          onTap: () => context.pop(),
                          child: const Text(
                            'Tidak',
                            style: TextStyle(
                              color: primary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                    } else {
                      /*
                        Terjadi kesalahan seperti email password salah
                        atau user tidak terdaftar
                      */
                      context.showSnackbar(state.message ?? '');
                    }
                  }
                },
                builder: (context, state) {
                  return ButtonCustom(
                    title: state.status == StatusLogin.loading
                        ? 'Loading...'
                        : 'Masuk',
                    onPressed: state.status == StatusLogin.loading
                        ? null
                        : () => _login(), // Function _login terdapat di bawah
                  );
                },
              ),
              verticalSpace(40),
              Wrap(
                spacing: 8,
                children: [
                  Text(
                    'Belum Punya Akun ?',
                    style: TextStyle(color: grey.withOpacity(0.8)),
                  ),
                  GestureDetector(
                    onTap: () => context.pushNamed('register'),
                    child: const Text(
                      'Daftar',
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

  _login() {
    if (_emailController.text.isEmpty ||
        !_emailController.text.isValidEmail()) {
      context.showSnackbar('Email tidak valid');
    } else if (RegExp(r"\s").hasMatch(_passwordController.text) ||
        _passwordController.text.isEmpty) {
      context.showSnackbar('Password tidak valid');
    } else if (_passwordController.text.length < 7) {
      context.showSnackbar('Password kurang dari 7');
    } else {
      FocusManager.instance.primaryFocus?.unfocus();
      context.read<LoginBloc>().add(OnLogin(
          email: _emailController.text, password: _passwordController.text));
    }
  }
}
