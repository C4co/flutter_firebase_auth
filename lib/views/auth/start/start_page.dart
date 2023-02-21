import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/views/auth/start/components/auth_item.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:go_router/go_router.dart';
import '/core/core.dart' show AuthService, AppSnackBar, AppButton;

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  final _auth = AuthService();

  continueWithGoogle() async {
    String result = await _auth.signInWithGoogle();

    if (mounted) {
      if (result == 'Success') {
        context.go('/');

        return;
      }

      AppSnackBar.show(message: result, context: context);
    }
  }

  showOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SizedBox(
        height: 200,
        child: Column(
          children: [
            AuthOption(
              action: () {
                continueWithGoogle();
              },
              icon: FontAwesome5.google,
              label: 'Continue with Google',
            ),
            const Divider(height: 1),
            AuthOption(
              action: () {
                context.go('/start/login');
              },
              icon: FontAwesome5.envelope,
              label: 'Enter with email and password',
            ),
            const Divider(height: 1),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: Container()),
            const Text(
              'Flutter\nFirebase',
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.w300,
                height: 1,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            AppButton(
              onPressed: () {
                showOptions(context);
              },
              label: 'Start',
            )
          ],
        ),
      ),
    );
  }
}
