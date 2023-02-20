import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:validatorless/validatorless.dart';
import '/core/core.dart' show AuthService, AppSnackBar, AppButton;

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _auth = AuthService();

  bool _securePassword = true;
  bool _isLoading = false;

  registerHandle() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      String? result = await _auth.registration(
        email: _emailController.text,
        password: _passwordController.text,
      );

      if (mounted) {
        if (result == 'Success') {
          context.go('/');
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
                    'Create new account',
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
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
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _emailController,
                    validator: Validatorless.multiple(
                      [
                        Validatorless.required('Name is required'),
                        Validatorless.email('Invalid email'),
                      ],
                    ),
                    decoration: const InputDecoration(
                      label: Text('Email'),
                      prefixIcon: Icon(Icons.email),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _securePassword,
                    validator: Validatorless.multiple(
                      [
                        Validatorless.required('Password is required'),
                        Validatorless.min(6, 'Must be at least 6 characters'),
                      ],
                    ),
                    decoration: InputDecoration(
                      label: const Text('Password'),
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _securePassword = !_securePassword;
                          });
                        },
                        icon: Icon(
                          _securePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  AppButton(
                    label: 'Submit',
                    loading: _isLoading,
                    fullWidth: true,
                    onPressed: () {
                      registerHandle();
                    },
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
