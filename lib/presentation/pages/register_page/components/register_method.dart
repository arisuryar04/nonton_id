import 'package:flutter/material.dart';

import '../../../../core/extension/context_ext.dart';
import '../../../../core/extension/string_ext.dart';
import '../../../bloc/bloc.dart';

clearTextEditing(
  TextEditingController name,
  TextEditingController email,
  TextEditingController password,
  TextEditingController confirmPassword,
) {
  name.clear();
  email.clear();
  password.clear();
  confirmPassword.clear();
}

register(
  BuildContext context, {
  required String name,
  required String email,
  required String password,
  required String confirmPassword,
}) {
  if (RegExp(r"\s").hasMatch(name) || name.isEmpty) {
    context.showSnackbar('Nama tidak boleh kosong');
  } else if (email.isEmpty || email.isValidEmail()) {
    context.showSnackbar('Email tidak valid');
  } else if (RegExp(r"\s").hasMatch(password) || password.isEmpty) {
    context.showSnackbar('Password tidak valid');
  } else if (password.length < 7) {
    context.showSnackbar('Password kurang dari 7');
  } else if (confirmPassword != password) {
    context.showSnackbar('Konfirmasi password tidak sesuai');
  } else {
    FocusManager.instance.primaryFocus?.unfocus();
    context.read<RegisterBloc>().add(OnRegister(
          email: email,
          password: password,
          name: name,
          balance: 0,
          createdAt: DateTime.now(),
          photoUrl: null,
        ));
  }
}
