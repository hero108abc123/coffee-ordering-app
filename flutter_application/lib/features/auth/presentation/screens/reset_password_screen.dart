import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/config/theme/app_pallate.dart';
import 'package:iconly/iconly.dart';

import '../widgets/auth_widgets.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

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
                'Reset your Password',
                style: TextStyle(
                  color: AppPallate.headerTextColor,
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 21),
              const Text(
                'Enter your new password',
                style: TextStyle(
                  color: AppPallate.textColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 20),
              AuthTextField(
                icon: const Icon(IconlyLight.lock),
                textLabel: 'New Password',
                controller: _passwordController,
                passwordVisible: true,
              ),
              const SizedBox(height: 12),
              AuthTextField(
                icon: const Icon(IconlyLight.lock),
                textLabel: 'Confirm New Password',
                controller: _confirmPasswordController,
                passwordVisible: true,
              ),
              const SizedBox(height: 100),
              AuthSubmitButton(
                onPressed: () {
                  if (kDebugMode) {
                    print("press");
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
