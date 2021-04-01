import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText;
  final Widget suffixIcon;
  final String labelText;
  final IconData icon;
  final String Function(String) validator;

  const CustomTextField(
      {Key key,
      this.controller,
      this.obscureText,
      this.suffixIcon,
      this.labelText,
      this.icon,
      this.validator})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        labelText: labelText,
        prefixIcon: Icon(icon, color: Theme.of(context).primaryColor, size: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
      ),
    );
  }
}
