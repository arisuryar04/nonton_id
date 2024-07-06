import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constant/color.dart';
import '../../widgets/widgets.dart';
import 'components/components.dart';

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
              buttonRegister(
                name: _nameController,
                email: _emailController,
                password: _passwordController,
                confirmPassword: _confirmPasswordController,
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
}
