import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '/core/core.dart';

mixin StartController {
  final _auth = AuthService();

  continueWithGoogle(BuildContext context) async {
    String result = await _auth.signInWithGoogle();

    if (context.mounted) {
      if (result == 'Success') {
        context.go('/');

        return;
      }

      AppSnackBar.show(message: result, context: context);
    }
  }
}
