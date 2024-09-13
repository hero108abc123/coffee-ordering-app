// import 'package:device_preview/device_preview.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/core/common/cubit/app_user_cubit.dart';
import 'package:flutter_application/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_application/features/auth/presentation/di/auth_init_dependencies.dart';
import 'package:flutter_application/features/auth/presentation/screens/auth_feature.dart';
import 'package:flutter_application/features/home/presentation/screens/home_feature.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await authInitDependencies();
  HttpOverrides.global = MyHttpOverrides();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => serviceLocator<AppUserCubit>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<AuthBloc>(),
        ),
      ],
      child: const MainApp(),
    ),

    // MultiBlocProvider(
    //   providers: [
    //     BlocProvider(
    //       create: (_) => serviceLocator<AppUserCubit>(),
    //     ),
    //     BlocProvider(
    //       create: (_) => serviceLocator<AuthBloc>(),
    //     ),
    //   ],
    //   child: DevicePreview(
    //     enabled: !kReleaseMode,
    //     builder: (content) => const MainApp(),
    //   ),
    // ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({
    super.key,
  });

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthIsUserLoggedIn());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // locale: DevicePreview.locale(context),
      // builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      title: 'Ordinary Coffee House',
      home: BlocSelector<AppUserCubit, AppUserState, bool>(
        selector: (state) {
          return state is AppUserLoggedIn;
        },
        builder: (context, isLoggedIn) {
          if (isLoggedIn) {
            return const HomeScreen();
          }
          return const OnBoardingScreen();
        },
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
