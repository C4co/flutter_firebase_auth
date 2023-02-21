import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/views/auth/verify_email/verify_email_controller.dart';
import '/core/core.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({super.key});

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage>
    with VerifyEmailController {
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
                loading: emailSended == 'loading',
                hidden: emailSended == 'yes',
                fullWidth: true,
                onPressed: () {
                  handleSendEmail();
                },
                label: 'Ressend email',
              ),
              if (emailSended == 'yes')
                AppButton(
                  onPressed: null,
                  label: 'Ressend email $counter',
                ),
            ],
          ),
        ),
      ),
    );
  }
}
