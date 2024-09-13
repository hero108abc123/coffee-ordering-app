import 'package:flutter/material.dart';
import 'package:flutter_application/config/theme/app_pallate.dart';
import 'package:lottie/lottie.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallate.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Lottie.asset("images/load.json"),
            const Text(
              "Ordinary Coffee House",
              style: TextStyle(
                color: AppPallate.splashTextColor,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            )
          ],
        ),
      ),
    );
  }
}
