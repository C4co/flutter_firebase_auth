import 'package:flutter/material.dart';
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
                if (_isLoading)
                  const Center(
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(),
                    ),
                  ),
                if (!_isLoading && !_isSuccess)
                  FilledButton(
                    onPressed: () async {
                      // check email here!
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          _isLoading = true;
                        });

                        String? result = await _auth.forgotPassword(
                          email: _emailController.text,
                        );

                        if (mounted) {
                          if (result == 'Success') {
                            var snack = SnackBar(
                              content: Row(
                                children: const [
                                  Text('Email sended'),
                                ],
                              ),
                            );

                            ScaffoldMessenger.of(context).clearSnackBars();
                            ScaffoldMessenger.of(context).showSnackBar(snack);

                            setState(() {
                              _isLoading = false;
                              _isSuccess = true;
                            });

                            return;
                          }

                          var snack = SnackBar(
                            backgroundColor:
                                Theme.of(context).colorScheme.error,
                            content: Row(
                              children: [
                                Text(result!),
                              ],
                            ),
                          );

                          ScaffoldMessenger.of(context).clearSnackBars();
                          ScaffoldMessenger.of(context).showSnackBar(snack);
                        }

                        setState(() {
                          _isLoading = false;
                        });
                      }
                    },
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
