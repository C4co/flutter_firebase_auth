import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({super.key});

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  Timer? _timer;
  String _emailSended = 'no';
  int _counter = 100;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  checkEmail(BuildContext context) {
    _timer = Timer.periodic(const Duration(seconds: 3), (insideTimer) {
      User? user = FirebaseAuth.instance.currentUser;
      user?.reload();

      if (user?.emailVerified == true) {
        _timer?.cancel();
        context.go('/home');
      }
    });
  }

  tictac() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _emailSended = 'yes';
        _counter--;
      });

      if (_counter == 0) {
        debugPrint('Ressend email again');
        timer.cancel();
        setState(() {
          _counter = 100;
          _emailSended = 'no';
        });
      }
    });
  }

  SnackBar getSnack(String text) {
    return SnackBar(
      content: Row(
        children: [
          const SizedBox(width: 10),
          Flexible(
            child: Text(
              text,
              overflow: TextOverflow.fade,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    checkEmail(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Email verification'),
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
        padding: const EdgeInsets.all(40),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              color: Theme.of(context).colorScheme.primary,
              Icons.mark_email_unread,
              size: 50,
            ),
            const SizedBox(height: 10),
            Text(
              'Verify your email address',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
            Text(
              'We send a link to (${FirebaseAuth.instance.currentUser?.email}) address to you confirm the verification.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 50),
            const Divider(),
            const SizedBox(height: 10),
            const Text(
              'You can ressend email if you don\'t received or the link was expired',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15),
            if (_emailSended == 'loading')
              const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(),
              ),
            if (_emailSended == 'no')
              FilledButton(
                onPressed: () async {
                  setState(() {
                    _emailSended = 'loading';
                  });

                  try {
                    await FirebaseAuth.instance.currentUser
                        ?.sendEmailVerification();

                    var snack = getSnack('Email sended');

                    if (mounted) {
                      ScaffoldMessenger.of(context).clearSnackBars();
                      ScaffoldMessenger.of(context).showSnackBar(snack);
                    }
                  } catch (e) {
                    var snack = getSnack('Email sended');

                    if (mounted) {
                      ScaffoldMessenger.of(context).clearSnackBars();
                      ScaffoldMessenger.of(context).showSnackBar(snack);
                    }
                  }

                  tictac();
                },
                child: const Text('Ressend email'),
              ),
            if (_emailSended == 'yes')
              FilledButton(
                onPressed: null,
                child: Text('Ressend email $_counter'),
              ),
          ],
        )),
      ),
    );
  }
}
