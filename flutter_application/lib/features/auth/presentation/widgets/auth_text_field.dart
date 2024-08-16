import 'package:flutter/material.dart';
import 'package:flutter_application/config/theme/app_pallate.dart';

class AuthTextField extends StatelessWidget {
  final Icon icon;
  final String textLabel;
  const AuthTextField({
    super.key,
    required this.icon,
    required this.textLabel,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        prefixIcon: icon,
        label: Text(
          textLabel,
          style: const TextStyle(
            color: AppPallate.formTextColor,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
