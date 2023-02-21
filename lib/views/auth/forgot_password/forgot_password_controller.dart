import 'package:flutter/widgets.dart';
import '/core/core.dart';

mixin ForgotPasswordController<T extends StatefulWidget> on State<T> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final auth = AuthService();
  bool isLoading = false;
  bool isSuccess = false;

  submitHandle(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      String? result = await auth.forgotPassword(
        email: emailController.text,
      );

      if (mounted) {
        if (result == 'Success') {
          AppSnackBar.show(
            message: 'Email sended',
            context: context,
          );

          setState(() {
            isLoading = false;
            isSuccess = true;
          });

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
