import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constant/color.dart';
import '../../../core/extension/context_ext.dart';
import '../../../core/extension/string_ext.dart';
import '../../bloc/bloc.dart';
import '../../widgets/widgets.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
                hint: 'Nama',
                controller: _nameController,
              ),
              verticalSpace(20),
              TextFieldCustom(
                hint: 'Email',
                controller: _emailController,
              ),
              verticalSpace(20),
              TextFieldCustom(
                hint: 'Password',
                controller: _passwordController,
                obscureText: true,
              ),
              verticalSpace(20),
              TextFieldCustom(
                hint: 'Konfirmasi Password',
                controller: _confirmPasswordController,
                obscureText: true,
                textInputAction: TextInputAction.done,
              ),
              verticalSpace(60),
              BlocConsumer<RegisterBloc, RegisterState>(
                listener: (context, state) {
                  if (state.status == StatusRegister.success) {
                    /*
                      Jika akun berhasil terdaftar dan show snackbar
                      untuk melakukan verifikasi email
                    */
                    context.showSnackbar(state.message ?? '');
                    _clearTextEditing(); // Function _clearTextEditing terdapat dibawah
                    context.pop();
                  } else if (state.status == StatusRegister.failed) {
                    /*
                      Jika gagal untuk mendaftar
                    */
                    context.showSnackbar(state.message ?? '');
                  }
                },
                builder: (context, state) {
                  return ButtonCustom(
                    title: state.status == StatusRegister.loading
                        ? 'Loading...'
                        : 'Daftar',
                    onPressed: state.status == StatusRegister.loading
                        ? null
                        : () =>
                            _register(), // Function _register() terdapat dibawah
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

  // Clear semua text editing controller
  _clearTextEditing() {
    _nameController.clear();
    _emailController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();
  }

  _register() {
    if (RegExp(r"\s").hasMatch(_nameController.text) ||
        _nameController.text.isEmpty) {
      context.showSnackbar('Nama tidak boleh kosong');
    } else if (_emailController.text.isEmpty ||
        !_emailController.text.isValidEmail()) {
      context.showSnackbar('Email tidak valid');
    } else if (RegExp(r"\s").hasMatch(_passwordController.text) ||
        _passwordController.text.isEmpty) {
      context.showSnackbar('Password tidak valid');
    } else if (_passwordController.text.length < 7) {
      context.showSnackbar('Password kurang dari 7');
    } else if (_confirmPasswordController.text != _passwordController.text) {
      context.showSnackbar('Konfirmasi password tidak sesuai');
    } else {
      FocusManager.instance.primaryFocus?.unfocus();
      context.read<RegisterBloc>().add(OnRegister(
            email: _emailController.text,
            password: _passwordController.text,
            name: _nameController.text,
            balance: 0,
            createdAt: DateTime.now(),
            photoUrl: null,
          ));
    }
  }
}
