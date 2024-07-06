import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constant/color.dart';
import '../../../../core/extension/context_ext.dart';
import '../../../bloc/bloc.dart';
import '../../../widgets/widgets.dart';
import 'login_method.dart';

Widget buttonLogin({
  required String email,
  required String password,
}) {
  return BlocConsumer<LoginBloc, LoginState>(
    listener: (context, state) {
      if (state.status == StatusLogin.success) {
        // Jika status success maka ke Home Page
        context.pushReplacementNamed('home');
      } else if (state.status == StatusLogin.failed) {
        if (state.message == 'Anda belum verifikasi email') {
          context.showDialogVerification(
            title: 'Verification Email',
            content:
                'Anda belum melakukan verifikasi email, apakah anda ingin dikirimkan ulang email verifikasi ?',
            onConfirm: BlocListener<SendVerificationEmailBloc,
                SendVerificationEmailState>(
              listener: (context, state) {
                if (state.status == StatusSendVerification.success) {
                  context.pop();
                  context.showSnackbar(state.message ?? '');
                } else if (state.status == StatusSendVerification.failed) {
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
          context.showSnackbar(state.message ?? '');
        }
      }
    },
    builder: (context, state) {
      return ButtonCustom(
        title: state.status == StatusLogin.loading ? 'Loading...' : 'Masuk',
        onPressed: state.status == StatusLogin.loading
            ? null
            : () => login(context, email: email, password: password),
      );
    },
  );
}
