import 'package:flutter/material.dart';

import '../../../../core/extension/context_ext.dart';
import '../../../bloc/bloc.dart';

changePassword(
  BuildContext context, {
  required String email,
  required String oldPassword,
  required String newPassword,
}) {
  FocusManager.instance.primaryFocus?.unfocus();
  if (oldPassword.isNotEmpty ||
      oldPassword != '' && newPassword.isNotEmpty ||
      newPassword != '') {
    context.read<UserBloc>().add(
          OnChangePassword(newPassword, email, oldPassword),
        );
  } else {
    context.showSnackbar(
      'Sandi sebelumnya dan sandi baru wajib diisi',
    );
  }
}
