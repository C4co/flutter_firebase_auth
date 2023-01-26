import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/core/themes/basic.theme.dart';
import 'package:go_router/go_router.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({super.key});

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  Timer? timer;

  checkEmail(BuildContext context) {
    timer = Timer.periodic(const Duration(seconds: 3), (insideTimer) {
      User? user = FirebaseAuth.instance.currentUser;
      user?.reload();

      if (user?.emailVerified == true) {
        timer?.cancel();
        context.go('/home');
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    checkEmail(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Validate your email'),
        actions: [
          IconButton(
            onPressed: () async {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Logout'),
                  content: const Text('Are you sure to leave the application'),
                  actions: [
                    TextButton(
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                        if (mounted) {
                          context.go('/');
                        }
                      },
                      child: const Text('Yes'),
                    )
                  ],
                ),
              );
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.mark_email_unread,
              size: 50,
              color: primaryColorShades,
            ),
            const SizedBox(height: 5),
            Text(
              'To continue you need to verify your email',
              style: ProjectText.title,
            ),
            const SizedBox(height: 5),
            Text(
              'If you already verified your email tap the above button to refresh the application.',
              style: ProjectText.text,
              textAlign: TextAlign.center,
            ),
          ],
        )),
      ),
    );
  }
}
