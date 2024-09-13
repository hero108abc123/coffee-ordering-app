import 'package:flutter/material.dart';
import 'package:flutter_application/config/theme/app_pallate.dart';
import 'package:iconly/iconly.dart';

import '../widgets/auth_widgets.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const ForgotPasswordScreen());
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            IconlyLight.arrow_left,
            color: AppPallate.headerTextColor,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 41),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 41),
              const Text(
                'Forgot Password?',
                style: TextStyle(
                  color: AppPallate.headerTextColor,
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 21),
              const Text(
                'Enter your email address',
                style: TextStyle(
                  color: AppPallate.textColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 20),
              AuthTextField(
                icon: const Icon(IconlyLight.message),
                textLabel: 'Email address',
                controller: _emailController,
              ),
              const SizedBox(height: 150),
              AuthSubmitButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {}
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
