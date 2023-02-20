import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '/core/core.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({super.key});

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  Timer? _checkEmailtimer;
  Timer? _ticTacTimer;
  String _emailSended = 'no';
  int _counter = 100;
  final _auth = AuthService();

  @override
  void dispose() {
    _checkEmailtimer?.cancel();
    _ticTacTimer?.cancel();
    super.dispose();
  }

  checkEmail(BuildContext context) {
    _checkEmailtimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      User? user = FirebaseAuth.instance.currentUser;
      user?.reload();

      if (user?.emailVerified == true) {
        timer.cancel();

        if (context.mounted) {
          context.go('/home');
        }
      }
    });
  }

  tictac() {
    _ticTacTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
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

  handleSendEmail() async {
    setState(() {
      _emailSended = 'loading';
    });

    var result = await _auth.sendEmailVerification();

    if (mounted) {
      if (result == 'Success') {
        AppSnackBar.show(message: 'Email sended', context: context);
      } else {
        AppSnackBar.show(message: result, context: context, error: true);
      }
    }

    tictac();
  }

  logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    if (mounted) {
      context.go('/');
    }
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
              AppDialog.show(
                title: 'Leave',
                context: context,
                content: 'Are you sure to leave the application?',
                actions: [
                  TextButton(
                    onPressed: () {
                      logout(context);
                    },
                    child: const Text('Yes'),
                  )
                ],
              );
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(40),
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
              AppButton(
                loading: _emailSended == 'loading',
                hidden: _emailSended == 'yes',
                fullWidth: true,
                onPress: () {
                  handleSendEmail();
                },
                label: 'Ressend email',
              ),
              if (_emailSended == 'yes')
                AppButton(
                  onPress: null,
                  label: 'Ressend email $_counter',
                ),
            ],
          ),
        ),
      ),
    );
  }
}
