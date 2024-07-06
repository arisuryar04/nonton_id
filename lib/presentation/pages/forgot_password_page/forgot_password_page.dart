import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constant/color.dart';
import '../../widgets/widgets.dart';
import 'components/components.dart';

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
              buttonSend(
                email: _emailController,
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
