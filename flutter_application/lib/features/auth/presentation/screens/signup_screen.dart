import 'package:flutter/material.dart';
import 'package:flutter_application/config/theme/app_pallate.dart';
import 'package:flutter_application/core/common/cubit/app_user_cubit.dart';
import 'package:flutter_application/core/common/widgets/loader.dart';
import 'package:flutter_application/core/common/widgets/show_snackbar.dart';
import 'package:flutter_application/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_application/features/auth/presentation/screens/signin_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';

import '../../../home/presentation/screens/home_feature.dart';
import '../screens/auth_feature.dart';
import '../widgets/auth_widgets.dart';

class SignUpScreen extends StatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const SignUpScreen());
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();
  final _mobileNumberController = TextEditingController();

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
            } else if (state is AuthFailure) {
              showSnackBar(context, state.message);
              Navigator.push(
                context,
                SignInScreen.route(),
              );
            }
          },
          child: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AccountSuccess) {
                context.read<AuthBloc>().add(
                      AuthSignIn(
                        email: _emailController.text.trim(),
                        password: _passwordController.text.trim(),
                      ),
                    );
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
                  if (state is AccountFailure) {
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
                          AuthTextField(
                            icon: const Icon(IconlyLight.profile),
                            textLabel: 'Username',
                            controller: _usernameController,
                          ),
                          const SizedBox(height: 12),
                          AuthTextField(
                            icon: const Icon(Icons.phone_android_outlined),
                            textLabel: 'Mobile Number',
                            controller: _mobileNumberController,
                          ),
                          const SizedBox(height: 12),
                          AuthTextField(
                            icon: const Icon(IconlyLight.message),
                            textLabel: 'Email Address',
                            controller: _emailController,
                          ),
                          const SizedBox(height: 12),
                          AuthTextField(
                            icon: const Icon(IconlyLight.lock),
                            textLabel: 'Password',
                            passwordVisible: true,
                            controller: _passwordController,
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
                          const SizedBox(height: 20),
                          AuthSubmitButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<AuthBloc>().add(
                                      AuthSignUp(
                                        userName:
                                            _usernameController.text.trim(),
                                        mobileNumber:
                                            _mobileNumberController.text.trim(),
                                        email: _emailController.text.trim(),
                                        password:
                                            _passwordController.text.trim(),
                                      ),
                                    );
                              }
                            },
                          ),
                          RichText(
                            text: TextSpan(
                              text: 'Already a member? ',
                              style: const TextStyle(
                                color: AppPallate.textColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                              children: [
                                WidgetSpan(
                                  child: GestureDetector(
                                    child: const Text(
                                      'Sign in',
                                      style: TextStyle(
                                        color: AppPallate.blueColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                          context, SignInScreen.route());
                                    },
                                  ),
                                )
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
          ),
        );
      },
    );
  }
}
