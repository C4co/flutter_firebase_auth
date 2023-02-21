import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';
import 'forgot_password_controller.dart';
import '/core/core.dart' show AppButton;

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage>
    with ForgotPasswordController {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recover password')),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
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
                  controller: emailController,
                  decoration: const InputDecoration(
                    label: Text('Email'),
                    prefixIcon: Icon(Icons.mail),
                  ),
                ),
                const SizedBox(height: 20),
                AppButton(
                  label: 'Submit',
                  hidden: isSuccess,
                  loading: isLoading,
                  fullWidth: true,
                  onPressed: () => {submitHandle(context)},
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
