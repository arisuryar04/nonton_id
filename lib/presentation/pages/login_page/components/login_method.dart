import 'package:flutter/material.dart';

import '../../../../core/extension/context_ext.dart';
import '../../../../core/extension/string_ext.dart';
import '../../../bloc/bloc.dart';

login(
  BuildContext context, {
  required String email,
  required String password,
}) {
  if (email.isEmpty || email.isValidEmail()) {
    context.showSnackbar('Email tidak valid');
  } else if (RegExp(r"\s").hasMatch(password) || password.isEmpty) {
    context.showSnackbar('Password tidak valid');
  } else if (password.length < 7) {
    context.showSnackbar('Password kurang dari 7');
  } else {
    FocusManager.instance.primaryFocus?.unfocus();
    context.read<LoginBloc>().add(OnLogin(email: email, password: password));
  }
}
