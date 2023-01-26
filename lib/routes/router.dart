import 'package:flutter_firebase/pages/auth/forgot_password/forgot_password_page.dart';
import 'package:flutter_firebase/pages/auth/start/start_page.dart';
import 'package:flutter_firebase/pages/auth/verify_email/verify_email_page.dart';
import 'package:flutter_firebase/pages/home/home_page.dart';
import 'package:flutter_firebase/pages/auth/login/login_page.dart';
import 'package:flutter_firebase/pages/auth/register/register_page.dart';
import 'package:flutter_firebase/pages/user/user_page.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      redirect: (context, state) async {
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
      },
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomePage(),
      routes: [
        GoRoute(
          path: 'user',
          builder: (context, state) => const UserPage(),
        )
      ],
    ),
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
    GoRoute(
      path: '/verify_email',
      builder: (context, state) => const VerifyEmailPage(),
    )
  ],
);
