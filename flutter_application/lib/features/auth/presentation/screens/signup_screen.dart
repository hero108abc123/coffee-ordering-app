import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/config/theme/app_pallate.dart';
import 'package:flutter_application/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:iconly/iconly.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            if (kDebugMode) {
              print("press");
            }
          },
          icon: const Icon(
            IconlyLight.arrow_left,
            color: AppPallate.headerTextColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 41),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 41),
            const Text(
              'Sign up',
              style: TextStyle(
                color: AppPallate.headerTextColor,
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 21),
            const Text(
              'Create an account here',
              style: TextStyle(
                color: AppPallate.textColor,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 20),
            const AuthTextField(
              icon: Icon(IconlyLight.profile),
              textLabel: 'Username',
            ),
            const SizedBox(height: 12),
            const AuthTextField(
              icon: Icon(Icons.phone_android_outlined),
              textLabel: 'Mobile Number',
            ),
            const SizedBox(height: 12),
            const AuthTextField(
              icon: Icon(IconlyLight.message),
              textLabel: 'Email Address',
            ),
            const SizedBox(height: 12),
            const AuthTextField(
              icon: Icon(IconlyLight.lock),
              textLabel: 'Password',
            ),
            const SizedBox(height: 12),
            const Text(
              'By signing up you agree with our Terms of Use',
              style: TextStyle(
                color: AppPallate.blueColor,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 260),
              child: Container(
                width: 64,
                height: 64,
                decoration: const BoxDecoration(
                    color: AppPallate.blueColor, shape: BoxShape.circle),
                child: IconButton(
                  icon: const Icon(
                    IconlyLight.arrow_right,
                    color: AppPallate.whiteColor,
                  ),
                  onPressed: () {
                    if (kDebugMode) {
                      print("press");
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 30),
            RichText(
              text: const TextSpan(
                text: 'Already a member? ',
                style: TextStyle(
                  color: AppPallate.textColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Sign in',
                    style: TextStyle(
                      color: AppPallate.blueColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
