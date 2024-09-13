import 'package:flutter/material.dart';
import 'package:flutter_application/config/theme/app_pallate.dart';
import 'package:flutter_application/core/common/cubit/app_user_cubit.dart';
import 'package:flutter_application/core/common/widgets/loader.dart';
import 'package:flutter_application/core/common/widgets/show_snackbar.dart';
import 'package:flutter_application/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';

import '../../../home/presentation/screens/home_feature.dart';
import 'auth_feature.dart';
import '../widgets/auth_widgets.dart';

class SignInScreen extends StatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const SignInScreen());
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
    _emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AppUserCubit, AppUserState, bool>(
      selector: (state) {
        return state is AppUserLoggedIn;
      },
      builder: (context, isLoggedIn) {
        if (isLoggedIn) {
          return const HomeScreen();
        }
        return BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              context.read<AuthBloc>().add(AuthIsUserLoggedIn());
            }
          },
          child: Scaffold(
            resizeToAvoidBottomInset: false,
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
            body: BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthFailure) {
                  return showSnackBar(context, state.message);
                }
              },
              builder: (context, state) {
                if (state is AuthLoading) {
                  return const Loader();
                }
                return Form(
                  key: _formKey,
                  child: Padding(
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
                        AuthTextField(
                          icon: const Icon(
                            IconlyLight.message,
                            color: AppPallate.headerTextColor,
                          ),
                          textLabel: 'Email Address',
                          controller: _emailController,
                        ),
                        const SizedBox(height: 12),
                        AuthTextField(
                          icon: const Icon(
                            IconlyLight.lock,
                            color: AppPallate.headerTextColor,
                          ),
                          textLabel: 'Password',
                          controller: _passwordController,
                          passwordVisible: true,
                        ),
                        const SizedBox(height: 30),
                        Center(
                          child: InkWell(
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: AppPallate.blueColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context, ForgotPasswordScreen.route());
                            },
                          ),
                        ),
                        const SizedBox(height: 90),
                        AuthSubmitButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<AuthBloc>().add(
                                    AuthSignIn(
                                      email: _emailController.text.trim(),
                                      password: _passwordController.text.trim(),
                                    ),
                                  );
                            }
                          },
                        ),
                        const SizedBox(height: 80),
                        RichText(
                          text: TextSpan(
                            text: 'New member? ',
                            style: const TextStyle(
                              color: AppPallate.textColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                            children: [
                              WidgetSpan(
                                child: GestureDetector(
                                  child: const Text(
                                    'Sign up',
                                    style: TextStyle(
                                      color: AppPallate.blueColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                        context, SignUpScreen.route());
                                  },
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
