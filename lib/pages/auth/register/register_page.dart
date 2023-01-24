import 'package:flutter/material.dart';
import 'package:flutter_firebase/core/themes/basic.theme.dart';
import 'package:go_router/go_router.dart';
import 'package:validatorless/validatorless.dart';

import '/core/services/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  final auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: SingleChildScrollView(
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Register in Firebase Flutter',
                    textAlign: TextAlign.start,
                    style: ProjectText.title,
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Text('Or'),
                      TextButton(
                        onPressed: () {
                          context.go('/start/login');
                        },
                        child: const Text('do login'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    controller: _emailController,
                    validator: Validatorless.multiple(
                      [
                        Validatorless.required('Name is required'),
                        Validatorless.email('Invalid email'),
                      ],
                    ),
                    decoration: const InputDecoration(label: Text('Email')),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _passwordController,
                    validator: Validatorless.multiple(
                      [
                        Validatorless.required('Password is required'),
                        Validatorless.min(6, 'Must be at least 6 characters'),
                      ],
                    ),
                    obscureText: true,
                    decoration: const InputDecoration(label: Text('Password')),
                  ),
                  const SizedBox(height: 20),
                  if (_isLoading)
                    const Center(
                      child: SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  if (!_isLoading)
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            _isLoading = true;
                          });

                          String? result = await auth.registration(
                            email: _emailController.text,
                            password: _passwordController.text,
                          );

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
                        child: Center(
                          child: Text('Submit'),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
