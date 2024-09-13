import 'package:flutter/material.dart';
import 'package:flutter_application/config/theme/app_pallate.dart';
import 'package:iconly/iconly.dart';

class AuthSubmitButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AuthSubmitButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 240),
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
          onPressed: onPressed,
        ),
      ),
    );
  }
}
