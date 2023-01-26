import 'package:flutter/material.dart';
import 'package:flutter_firebase/core/services/firebase_auth.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:go_router/go_router.dart';
import '/core/themes/basic.theme.dart';

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
                fontWeight: FontWeight.w200,
                height: 1,
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
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => SizedBox(
                    height: 200,
                    child: Column(
                      children: [
                        ListTile(
                          onTap: () async {
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
                          title: Row(
                            children: const [
                              Icon(FontAwesome5.google, color: Colors.red),
                              SizedBox(width: 20),
                              Text('Continue with google'),
                            ],
                          ),
                        ),
                        Divider(height: 1, color: Colors.grey.shade600),
                        ListTile(
                          onTap: () {
                            context.go('/start/login');
                          },
                          title: Row(
                            children: const [
                              Icon(FontAwesome5.envelope, color: Colors.grey),
                              SizedBox(width: 20),
                              Text('Login with email and password'),
                            ],
                          ),
                        ),
                        Divider(height: 1, color: Colors.grey.shade600),
                      ],
                    ),
                  ),
                );
              },
              child: const SizedBox(
                width: double.infinity,
                child: Center(
                  child: Text(
                    'Start',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
