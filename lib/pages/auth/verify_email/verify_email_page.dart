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
  @override
  Widget build(BuildContext context) {
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
              color: Colors.red,
            ),
            const SizedBox(height: 5),
            Text('To continue you need to verify your email',
                style: ProjectText.title),
            const SizedBox(height: 5),
            Text(
              'If you already verified your email tap the above button to refresh the application.',
              style: ProjectText.text,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () async {
                FirebaseAuth.instance.currentUser?.reload();
                final User? user = FirebaseAuth.instance.currentUser;

                if (!user!.emailVerified) {
                  var snack = SnackBar(
                    backgroundColor: Colors.red.shade700,
                    content: Row(
                      children: [
                        const Icon(
                          Icons.error,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 10),
                        Text('The email ${user.email} is unverified'),
                      ],
                    ),
                  );

                  if (mounted) {
                    ScaffoldMessenger.of(context).clearSnackBars();
                    ScaffoldMessenger.of(context).showSnackBar(snack);
                  }

                  return;
                }

                if (mounted) {
                  context.go('/home');
                }
              },
              child: const Text('Refresh'),
            )
          ],
        )),
      ),
    );
  }
}
