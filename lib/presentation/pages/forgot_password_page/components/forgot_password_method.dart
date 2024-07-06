import 'package:flutter/material.dart';

import '../../../../core/extension/context_ext.dart';
import '../../../../core/extension/string_ext.dart';
import '../../../bloc/bloc.dart';

forgotPassword(
  BuildContext context, {
  required String email,
}) {
  if (email.isEmpty || !email.isValidEmail()) {
    context.showSnackbar('Email tidak valid');
  } else {
    FocusManager.instance.primaryFocus?.unfocus();
    context.read<ForgotPasswordBloc>().add(OnForgotPassword(email));
  }
}
