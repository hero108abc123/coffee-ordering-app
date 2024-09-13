import 'package:flutter/material.dart';
import 'package:flutter_application/config/theme/app_pallate.dart';

class AuthTextField extends StatefulWidget {
  final Icon icon;
  final String textLabel;
  final TextEditingController controller;
  final bool passwordVisible;
  const AuthTextField({
    super.key,
    required this.controller,
    required this.icon,
    required this.textLabel,
    this.passwordVisible = false,
  });

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  bool isObsureText = false;
  Widget? suffixIcon;
  bool? isAlign;

  get label => widget.textLabel;
  @override
  void initState() {
    super.initState();
    if (widget.passwordVisible == true) {
      isObsureText = true;
      suffixIcon = IconButton(
        icon: Icon(isObsureText
            ? Icons.visibility_outlined
            : Icons.visibility_off_outlined),
        onPressed: () {
          setState(() {
            isObsureText = !isObsureText;
          });
        },
        color: AppPallate.headerTextColor,
      );
      isAlign = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isObsureText,
      controller: widget.controller,
      decoration: InputDecoration(
        prefixIcon: widget.icon,
        label: Text(
          widget.textLabel,
          style: const TextStyle(
            color: AppPallate.formTextColor,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
        suffixIcon: suffixIcon,
        alignLabelWithHint: isAlign,
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "$label is missing!";
        }
        return null;
      },
    );
  }
}
