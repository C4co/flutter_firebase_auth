import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:validatorless/validatorless.dart';
import '/core/services/firebase_auth.dart';
import '/core/themes/basic.theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;
  final auth = AuthService();

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
                  'Enter in Firebase Flutter',
                  textAlign: TextAlign.start,
                  style: ProjectText.title,
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Text('Or'),
                    TextButton(
                      onPressed: () {
                        context.go('/start/register');
                      },
                      child: const Text('create new account'),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
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
                TextFormField(
                  validator: Validatorless.required('Password is required'),
                  obscureText: true,
                  controller: _passwordController,
                  decoration: const InputDecoration(label: Text('Password')),
                ),
                const SizedBox(height: 5),
                TextButton(
                  onPressed: () {
                    context.go('/start/login/forgot_password');
                  },
                  child: const Text('Forgot your password?'),
                ),
                const SizedBox(height: 5),
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

                        String? result = await auth.login(
                          email: _emailController.text,
                          password: _passwordController.text,
                        );

                        // success
                        if (result == 'Success') {
                          if (mounted) {
                            context.go('/');
                          }
                          return;
                        }

                        // error
                        if (mounted) {
                          var snack = SnackBar(
                            backgroundColor: Colors.red.shade700,
                            content: Row(
                              children: [
                                const SizedBox(width: 10),
                                Flexible(
                                  child: Text(
                                    result!,
                                    overflow: TextOverflow.fade,
                                  ),
                                ),
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
            )),
          ),
        ),
      ),
    );
  }
}
