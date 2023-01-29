import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/pages/pages.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      redirect: (context, state) async {
        try {
          User? user = FirebaseAuth.instance.currentUser;
          user?.reload();

          if (user == null) {
            return '/start';
          } else {
            if (!user.emailVerified) {
              return '/verify_email';
            }

            return '/home';
          }
        } catch (e) {
          return '/';
        }
      },
    ),

    // Private
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomePage(),
      routes: [
        GoRoute(
          path: 'user',
          builder: (context, state) => const UserPage(),
        )
      ],
      redirect: (context, state) {
        return null;
      },
    ),

    // Private
    GoRoute(
      path: '/verify_email',
      builder: (context, state) => const VerifyEmailPage(),
    ),

    // Public
    GoRoute(
      path: '/start',
      builder: (context, state) => const StartPage(),
      routes: [
        GoRoute(
          path: 'login',
          builder: (context, state) => const LoginPage(),
          routes: [
            GoRoute(
              path: 'register',
              builder: (context, state) => const RegisterPage(),
            ),
            GoRoute(
              path: 'forgot_password',
              builder: (context, state) => const ForgotPasswordPage(),
            ),
          ],
        ),
      ],
    ),
  ],
);
