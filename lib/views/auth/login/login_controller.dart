import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '/core/core.dart';

mixin LoginController<T extends StatefulWidget> on State<T> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final auth = AuthService();
  bool isLoading = false;

  doLogin(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      String? result = await auth.login(
        email: emailController.text,
        password: passwordController.text,
      );

      if (mounted) {
        if (result == 'Success') {
          context.go('/');
          return;
        }

        AppSnackBar.show(
          message: result!,
          context: context,
          error: true,
        );
      }

      setState(() {
        isLoading = false;
      });
    }
  }
}
