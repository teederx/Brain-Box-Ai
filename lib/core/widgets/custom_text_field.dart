import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.icon,
    required this.hintText,
    this.validator,
    this.obscureText = false,
    this.onTap,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.textInputAction = TextInputAction.next,
  });

  final TextEditingController controller;
  final Icon icon;
  final bool isPassword;
  final String hintText;
  final String? Function(String?)? validator;
  final bool obscureText;
  final VoidCallback? onTap;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.never,
        isDense: false,
        icon: icon,
        hintText: hintText,
        suffixIconColor: Theme.of(context).iconTheme.color,
        suffixIcon:
            isPassword
                ? IconButton(
                  style: IconButton.styleFrom(padding: EdgeInsets.zero),
                  onPressed: onTap,
                  icon: Icon(
                    obscureText ? Icons.visibility_off : Icons.visibility,
                  ),
                  padding: EdgeInsets.zero,
                )
                : null,
      ),
      validator: validator,
      obscureText: obscureText,
    );
  }
}
