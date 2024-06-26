import 'package:go_router/go_router.dart';

import '../../presentation/pages/forgot_password_page/forgot_password_page.dart';
import '../../presentation/pages/home_page/home_page.dart';
import '../../presentation/pages/login_page/login_page.dart';
import '../../presentation/pages/register_page/register_page.dart';
import '../../presentation/pages/splash_page/splash_page.dart';

GoRouter get router => _router;

final _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'splash',
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/forgot-password',
      name: 'forgot-password',
      builder: (context, state) => const ForgotPasswordPage(),
    ),
    GoRoute(
      path: '/register',
      name: 'register',
      builder: (context, state) => const RegisterPage(),
    ),
    GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, state) => const HomePage(),
    ),
  ],
);
