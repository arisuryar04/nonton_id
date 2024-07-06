import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/extension/context_ext.dart';
import '../../../bloc/bloc.dart';
import '../../../widgets/widgets.dart';
import 'register_method.dart';

Widget buttonRegister({
  required TextEditingController name,
  required TextEditingController email,
  required TextEditingController password,
  required TextEditingController confirmPassword,
}) {
  return BlocConsumer<RegisterBloc, RegisterState>(
    listener: (context, state) {
      if (state.status == StatusRegister.success) {
        context.showSnackbar(state.message ?? '');
        clearTextEditing(
          name,
          email,
          password,
          confirmPassword,
        );
        context.pop();
      } else if (state.status == StatusRegister.failed) {
        context.showSnackbar(state.message ?? '');
      }
    },
    builder: (context, state) {
      return ButtonCustom(
        title: state.status == StatusRegister.loading ? 'Loading...' : 'Daftar',
        onPressed: state.status == StatusRegister.loading
            ? null
            : () => register(
                  context,
                  name: name.text,
                  email: email.text,
                  password: password.text,
                  confirmPassword: confirmPassword.text,
                ),
      );
    },
  );
}
