import 'package:flutter/material.dart';

import '../../../../core/extension/context_ext.dart';
import '../../../bloc/bloc.dart';
import '../../../widgets/widgets.dart';
import 'change_password_method.dart';

Widget buttonChangePassword({
  required TextEditingController email,
  required TextEditingController oldPassword,
  required TextEditingController newPassword,
}) {
  return BlocConsumer<UserBloc, UserState>(
    listener: (context, state) {
      if (state.status == StatusUser.success) {
        oldPassword.clear();
        newPassword.clear();
        context.showSnackbar(state.message ?? '');
      } else if (state.status == StatusUser.failed) {
        context.showSnackbar(state.message ?? '');
      }
    },
    builder: (context, state) {
      return ButtonCustom(
        title: state.status == StatusUser.loading ? 'Loading...' : 'Ubah Sandi',
        width: context.fullWidth - 48,
        onPressed: state.status == StatusUser.loading
            ? null
            : () => changePassword(
                  context,
                  email: email.text,
                  newPassword: newPassword.text,
                  oldPassword: oldPassword.text,
                ),
      );
    },
  );
}
