import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:validatorless/validatorless.dart';
import '/core/core.dart' show AuthService, AppSnackBar, AppButton;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _auth = AuthService();

  bool _securePassword = true;
  bool _isLoading = false;
  submitHandle(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      String? result = await _auth.login(
        email: _emailController.text,
        password: _passwordController.text,
      );

      if (mounted) {
        // success
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
      appBar: AppBar(title: const Text('Login')),
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
                    'Enter in flutter firebase',
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Row(
                    children: [
                      const Text('Or'),
                      TextButton(
                        onPressed: () {
                          context.go('/start/login/register');
                        },
                        child: const Text('create new account'),
                      ),
                    ],
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
                      label: Text('Email'),
                      prefixIcon: Icon(Icons.email),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    validator: Validatorless.required('Password is required'),
                    obscureText: _securePassword,
                    controller: _passwordController,
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
                  const SizedBox(height: 5),
                  TextButton(
                    onPressed: () {
                      context.go('/start/login/forgot_password');
                    },
                    child: const Text('Forgot your password?'),
                  ),
                  const SizedBox(height: 5),
                  AppButton(
                    label: 'Submit',
                    loading: _isLoading,
                    fullWidth: true,
                    onPressed: () {
                      submitHandle(context);
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
