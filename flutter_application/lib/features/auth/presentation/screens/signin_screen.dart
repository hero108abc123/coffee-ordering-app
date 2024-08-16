import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/config/theme/app_pallate.dart';
import 'package:flutter_application/features/auth/presentation/widgets/auth_widgets.dart';
import 'package:iconly/iconly.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
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
              'Sign in',
              style: TextStyle(
                color: AppPallate.headerTextColor,
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 21),
            const Text(
              'Welcome back',
              style: TextStyle(
                color: AppPallate.textColor,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 20),
            const AuthTextField(
              icon: Icon(
                IconlyLight.message,
                color: AppPallate.headerTextColor,
              ),
              textLabel: 'Email Address',
            ),
            const SizedBox(height: 12),
            const AuthTextField(
              icon: Icon(
                IconlyLight.lock,
                color: AppPallate.headerTextColor,
              ),
              textLabel: 'Password',
            ),
            const SizedBox(height: 12),
            const Center(
              child: Text(
                'Forgot Password?',
                style: TextStyle(
                  color: AppPallate.blueColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 70, left: 260),
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
                text: 'New member? ',
                style: TextStyle(
                  color: AppPallate.textColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Sign up',
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
