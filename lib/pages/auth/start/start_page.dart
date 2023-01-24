import 'package:flutter/material.dart';
import 'package:flutter_firebase/core/services/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:fluttericon/font_awesome5_icons.dart';

import '../../../core/themes/basic.theme.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  final _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('Firebase flutter')),
      body: Container(
        color: primaryColorShades,
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
                height: 0.9,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              onPressed: () async {
                String result = await _auth.signInWithGoogle();

                if (result == 'Success') {
                  if (mounted) {
                    context.go('/');
                  }

                  return;
                }

                if (mounted) {
                  var snack = SnackBar(
                    backgroundColor: Colors.red.shade700,
                    content: Row(
                      children: [
                        const SizedBox(width: 10),
                        Flexible(
                          child: Text(
                            result,
                            overflow: TextOverflow.fade,
                          ),
                        ),
                      ],
                    ),
                  );

                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).showSnackBar(snack);
                }
              },
              child: SizedBox(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      FontAwesome5.google,
                      color: Colors.red,
                      size: 18,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'continue with google',
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              onPressed: () {
                context.go('/start/login');
              },
              child: SizedBox(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.mail,
                      size: 18,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'enter with email',
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
