import 'package:go_router/go_router.dart';

import '../../domain/entities/transaction.dart';
import '../../presentation/pages/pages.dart';

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
      routes: [
        GoRoute(
          path: 'update-profile',
          name: 'update-profile',
          builder: (context, state) => const UpdateProfilePage(),
        ),
        GoRoute(
          path: 'my-wallet',
          name: 'my-wallet',
          builder: (context, state) => const MyWalletPage(),
        ),
        GoRoute(
          path: 'change-password',
          name: 'change-password',
          builder: (context, state) => const ChangePasswordPage(),
        ),
        GoRoute(
          path: 'movie-detail',
          name: 'movie-detail',
          builder: (context, state) => MovieDetailPage(
            isUpComing: state.extra as bool,
          ),
          routes: [
            GoRoute(
              path: 'seats',
              name: 'seats',
              builder: (context, state) => SeatsPage(
                transaction: state.extra as Transaction,
              ),
              routes: [
                GoRoute(
                  path: 'order-summary',
                  name: 'order-summary',
                  builder: (context, state) => OrderSummaryPage(
                    transaction: state.extra as Transaction,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);
