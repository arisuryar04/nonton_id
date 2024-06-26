import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/extension/context_ext.dart';
import '../../bloc/bloc.dart';
import '../../widgets/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocConsumer<LogoutBloc, LogoutState>(
          listener: (context, state) {
            if (state.status == StatusLogout.success) {
              context.read<LoginBloc>().add(OnGetLoggedUser());
              context.pushReplacementNamed('login');
            } else if (state.status == StatusLogout.failed) {
              context.showSnackbar(state.message ?? '');
            }
          },
          builder: (context, state) {
            return ButtonCustom(
              title: state.status == StatusLogout.loading
                  ? 'Loading...'
                  : 'Logout',
              onPressed: state.status == StatusLogout.loading
                  ? null
                  : () => context.read<LogoutBloc>().add(OnLogout()),
            );
          },
        ),
      ),
    );
  }
}
