import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/views/auth/register/register_controller.dart';
import 'package:go_router/go_router.dart';
import 'package:validatorless/validatorless.dart';
import '/core/core.dart' show AppButton;

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> with RegisterController {
  bool _securePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: SingleChildScrollView(
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: formKey,
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
                    controller: emailController,
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
                    controller: passwordController,
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
                    loading: isLoading,
                    fullWidth: true,
                    onPressed: () {
                      registerNewUser();
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
