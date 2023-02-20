import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';
import '/core/core.dart';

class EmailLink extends StatefulWidget {
  const EmailLink({super.key});

  @override
  State<EmailLink> createState() => _EmailLinkState();
}

class _EmailLinkState extends State<EmailLink> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _authService = AuthService();
  bool _isLoading = false;
  bool _success = false;

  sendLink(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text;

      setState(() {
        _isLoading = true;
        _success = false;
      });

      String result =
          await _authService.sendSignInLinkEmail(emailAddress: email);

      if (mounted) {
        if (result == 'Success') {
          AppSnackBar.show(
            message: 'Link sended',
            context: context,
          );

          setState(() {
            _isLoading = false;
            _success = true;
          });

          return;
        }

        setState(() {
          _isLoading = false;
          _success = false;
        });

        AppSnackBar.show(
          message: result,
          context: context,
          error: true,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Email link')),
      body: Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Enter your email to receiver an authentication link',
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  label: Text('Email'),
                  prefixIcon: Icon(Icons.email),
                ),
                validator: Validatorless.multiple(
                  [
                    Validatorless.email('The field must be an email'),
                    Validatorless.required('Email field is required')
                  ],
                ),
              ),
              const SizedBox(height: 20),
              AppButton(
                onPress: () {
                  sendLink(context);
                },
                label: 'Submit',
                loading: _isLoading,
                hidden: _success,
                fullWidth: true,
              )
            ],
          ),
        ),
      ),
    );
  }
}
