import 'package:flutter/material.dart';

import '../../../core/constant/color.dart';
import '../../../core/extension/context_ext.dart';
import '../../bloc/bloc.dart';
import '../../widgets/widgets.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  late final _emailController = TextEditingController();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();

  _changePassword() {
    FocusManager.instance.primaryFocus?.unfocus();
    if (_oldPasswordController.text.isNotEmpty ||
        _oldPasswordController.text != '' &&
            _newPasswordController.text.isNotEmpty ||
        _newPasswordController.text != '') {
      context.read<UserBloc>().add(OnChangePassword(_newPasswordController.text,
          _emailController.text, _oldPasswordController.text));
    } else {
      context.showSnackbar(
        'Sandi sebelumnya dan sandi baru wajib diisi',
      );
    }
  }

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
            BlocConsumer<UserBloc, UserState>(
              listener: (context, state) {
                if (state.status == StatusUser.success) {
                  _oldPasswordController.clear();
                  _newPasswordController.clear();
                  context.showSnackbar(state.message ?? '');
                } else if (state.status == StatusUser.failed) {
                  context.showSnackbar(state.message ?? '');
                }
              },
              builder: (context, state) {
                return ButtonCustom(
                  title: state.status == StatusUser.loading
                      ? 'Loading...'
                      : 'Ubah Sandi',
                  width: context.fullWidth - 48,
                  onPressed: state.status == StatusUser.loading
                      ? null
                      : () => _changePassword(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
