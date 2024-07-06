import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constant/color.dart';
import '../../widgets/widgets.dart';
import 'components/button_login.dart';

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
              buttonLogin(
                email: _emailController.text,
                password: _passwordController.text,
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
}
