import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/extension/context_ext.dart';
import '../../../bloc/bloc.dart';
import '../../../widgets/widgets.dart';

Widget buttonLogout() {
  return BlocConsumer<LogoutBloc, LogoutState>(
    listener: (context, state) {
      if (state.status == StatusLogout.success) {
        context.pushReplacementNamed('login');
      } else if (state.status == StatusLogout.failed) {
        context.showSnackbar(state.message ?? '');
      }
    },
    builder: (context, state) {
      return ButtonCustom(
        title: state.status == StatusLogout.loading ? 'Tunggu...' : 'Keluar',
        onPressed: state.status == StatusLogout.loading
            ? null
            : () => context.read<LogoutBloc>().add(OnLogout()),
      );
    },
  );
}
