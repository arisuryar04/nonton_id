import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/extension/context_ext.dart';
import '../../../bloc/bloc.dart';
import '../../../widgets/widgets.dart';
import 'components.dart';

Widget buttonSend({required TextEditingController email}) {
  return BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
    listener: (context, state) {
      if (state.status == StatusForgotPassword.success) {
        context.showSnackbar(state.message ?? '');
        email.clear();
        context.pop();
      } else if (state.status == StatusForgotPassword.failed) {
        context.showSnackbar(state.message ?? '');
      }
    },
    builder: (context, state) {
      return ButtonCustom(
        title: state.status == StatusForgotPassword.loading
            ? 'Loading...'
            : 'Kirim',
        onPressed: state.status == StatusForgotPassword.loading
            ? null
            : () => forgotPassword(context, email: email.text),
      );
    },
  );
}
