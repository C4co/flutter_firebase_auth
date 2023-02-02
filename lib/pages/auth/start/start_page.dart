import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:go_router/go_router.dart';
import '/core/core.dart' show AuthService, AppSnackBar;

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
                fontSize: 60,
                fontWeight: FontWeight.w300,
                height: 1,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            FilledButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => SizedBox(
                    height: 200,
                    child: Column(
                      children: [
                        ListTile(
                          onTap: () {
                            continueWithGoogle();
                          },
                          title: Row(
                            children: [
                              Icon(
                                FontAwesome5.google,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              const SizedBox(width: 20),
                              const Text('Continue with google'),
                            ],
                          ),
                        ),
                        const Divider(height: 1),
                        ListTile(
                          onTap: () {
                            context.go('/start/login');
                          },
                          title: Row(
                            children: [
                              Icon(
                                FontAwesome5.envelope,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              const SizedBox(width: 20),
                              const Text('Login with email and password'),
                            ],
                          ),
                        ),
                        const Divider(height: 1),
                      ],
                    ),
                  ),
                );
              },
              child: const SizedBox(
                width: double.infinity,
                child: Center(
                  child: Text('Start'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
