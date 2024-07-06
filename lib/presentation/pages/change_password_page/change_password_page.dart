import 'package:flutter/material.dart';

import '../../../core/constant/color.dart';
import '../../bloc/bloc.dart';
import '../../widgets/widgets.dart';
import 'components/components.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  late final _emailController = TextEditingController();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final user = context.read<UserBloc>().state.user;
    _emailController.text = user!.email!;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AppBarCustom(
              title: 'Ubah Kata Sandi',
              rightChild: Icon(
                Icons.password_rounded,
                color: white,
              ),
            ),
            verticalSpace(25),
            TextFieldEdited(
              label: 'Email',
              controller: _emailController,
            ),
            verticalSpace(25),
            TextFieldEdited(
              label: 'Sandi Sebelumnya',
              controller: _oldPasswordController,
              isEnabled: true,
            ),
            verticalSpace(25),
            TextFieldEdited(
              label: 'Sandi Baru',
              controller: _newPasswordController,
              isEnabled: true,
            ),
            verticalSpace(48),
            buttonChangePassword(
              email: _emailController,
              newPassword: _newPasswordController,
              oldPassword: _oldPasswordController,
            ),
          ],
        ),
      ),
    );
  }
}
