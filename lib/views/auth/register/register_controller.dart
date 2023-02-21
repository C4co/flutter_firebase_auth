import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import '/core/core.dart';

mixin RegisterController<T extends StatefulWidget> on State<T> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final auth = AuthService();

  bool isLoading = false;

  registerNewUser() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      String? result = await auth.registration(
        email: emailController.text,
        password: passwordController.text,
      );

      if (context.mounted) {
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
