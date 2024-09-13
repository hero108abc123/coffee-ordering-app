import 'package:flutter/material.dart';
import 'package:flutter_application/config/theme/app_pallate.dart';
import 'package:flutter_application/core/common/widgets/loader.dart';
import 'package:flutter_application/core/common/widgets/show_snackbar.dart';
import 'package:flutter_application/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import 'auth_feature.dart';
import '../widgets/auth_widgets.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthFailure) {
          return showSnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        if (state is AuthLoading) {
          return const Loader();
        }
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 41),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Lottie.asset("images/on1.json"),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    'Making your days with our coffee.',
                    style: TextStyle(
                      color: AppPallate.headerTextColor,
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 12),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    'The best grain, the finest roast, the most powerful flavor.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppPallate.textColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                AuthSubmitButton(
                  onPressed: () {
                    Navigator.push(context, SignInScreen.route());
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
