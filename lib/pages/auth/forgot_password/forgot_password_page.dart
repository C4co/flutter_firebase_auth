import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/core/components/loading.dart';
import 'package:flutter_firebase_auth/core/components/snackbar.dart';
import 'package:validatorless/validatorless.dart';
import '/core/core.dart' show AuthService;

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _auth = AuthService();
  bool _isLoading = false;
  bool _isSuccess = false;

  submitHandle(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      String? result = await _auth.forgotPassword(
        email: _emailController.text,
      );

      if (mounted) {
        if (result == 'Success') {
          AppSnackBar.show(
            message: 'Email sended',
            context: context,
          );

          setState(() {
            _isLoading = false;
            _isSuccess = true;
          });

          return;
        }

        AppSnackBar.show(
          message: result!,
          context: context,
          error: true,
        );
      }

      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recover password')),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Enter your email to receiver a link to reset your password',
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  validator: Validatorless.multiple(
                    [
                      Validatorless.email('The field must be and email'),
                      Validatorless.required('Email is required'),
                    ],
                  ),
                  controller: _emailController,
                  decoration: const InputDecoration(
                      label: Text('Email'), prefixIcon: Icon(Icons.mail)),
                ),
                const SizedBox(height: 20),
                if (_isLoading) const Loading(),
                if (!_isLoading && !_isSuccess)
                  FilledButton(
                    onPressed: () => {submitHandle(context)},
                    child: const SizedBox(
                      width: double.infinity,
                      child: Center(child: Text('Submit')),
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
