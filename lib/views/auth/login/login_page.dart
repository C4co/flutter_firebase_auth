import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/views/auth/login/login_controller.dart';
import 'package:go_router/go_router.dart';
import 'package:validatorless/validatorless.dart';
import '/core/core.dart' show AppButton;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with LoginController {
  bool securePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
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
                    controller: emailController,
                    decoration: const InputDecoration(
                      label: Text('Email'),
                      prefixIcon: Icon(Icons.email),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    validator: Validatorless.required('Password is required'),
                    obscureText: securePassword,
                    controller: passwordController,
                    decoration: InputDecoration(
                      label: const Text('Password'),
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            securePassword = !securePassword;
                          });
                        },
                        icon: Icon(
                          securePassword
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
                    loading: isLoading,
                    fullWidth: true,
                    onPressed: () {
                      doLogin(context);
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
