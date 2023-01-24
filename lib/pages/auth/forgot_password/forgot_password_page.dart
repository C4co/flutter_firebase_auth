import 'package:flutter/material.dart';
import 'package:flutter_firebase/core/services/firebase_auth.dart';
import 'package:validatorless/validatorless.dart';
import '/core/themes/basic.theme.dart';

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
                Text(
                  'Recover password',
                  textAlign: TextAlign.start,
                  style: ProjectText.title,
                ),
                const SizedBox(height: 5),
                Text(
                  'Enter your email to receiver a link to reset your password',
                  textAlign: TextAlign.start,
                  style: ProjectText.text,
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
                  decoration: const InputDecoration(label: Text('Email')),
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
                  ElevatedButton(
                    onPressed: () async {
                      // check email here!
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          _isLoading = true;
                        });

                        String? result = await _auth.forgotPassword(
                          email: _emailController.text,
                        );

                        if (result == 'Success') {
                          var snack = SnackBar(
                            backgroundColor: Colors.green.shade700,
                            content: Row(
                              children: const [
                                Text('Email sended'),
                              ],
                            ),
                          );

                          if (mounted) {
                            ScaffoldMessenger.of(context).clearSnackBars();
                            ScaffoldMessenger.of(context).showSnackBar(snack);
                          }

                          setState(() {
                            _isLoading = false;
                            _isSuccess = true;
                          });

                          return;
                        }

                        var snack = SnackBar(
                          backgroundColor: Colors.red.shade700,
                          content: Row(
                            children: [
                              Text(result!),
                            ],
                          ),
                        );

                        if (mounted) {
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
