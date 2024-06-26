import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../bloc/bloc.dart';
import '../../widgets/widgets.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    context.read<LoginBloc>().add(OnGetLoggedUser());
    super.initState();
    /*
      Saat peratama kali masuk aplikasi
      jika user sudah pernah login sebelumnya
      maka akan langsung diarahkan ke home page
      jika user sebelumnya tidak login
      maka akan diarahkan ke login page
    */
    Future.delayed(const Duration(seconds: 8)).whenComplete(
      () => context.read<LoginBloc>().state.uid != null &&
              context.read<LoginBloc>().state.status == StatusLogin.success
          ? context.pushReplacementNamed('home')
          : context.pushReplacementNamed('login'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: AppLogo(),
      ),
    );
  }
}
