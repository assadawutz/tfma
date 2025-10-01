import 'package:flutter/material.dart';

import '../util/color.dart';

enum ValidationType {
  normal,
  email,
  password,
}

class CustomTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController? controller;
  final ValidationType validationType;
  final bool requiredField;

  const CustomTextField({
    Key? key,
    required this.hintText,
    this.obscureText = false,
    this.controller,
    this.validationType = ValidationType.normal,
    this.requiredField = true,
  }) : super(key: key);

  String? _validate(String? value) {
    if (requiredField && (value == null || value.isEmpty)) {
      return 'This field is required';
    }

    if (validationType == ValidationType.email) {
      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      if (!emailRegex.hasMatch(value!)) {
        return 'Invalid email format';
      }
    }

    if (validationType == ValidationType.password) {
      final upperCase = RegExp(r'[A-Z]');
      final lowerCase = RegExp(r'[a-z]');
      final number = RegExp(r'\d');

      if (!upperCase.hasMatch(value!)) {
        return 'Must include uppercase letter';
      }
      if (!lowerCase.hasMatch(value)) {
        return 'Must include lowercase letter';
      }
      if (!number.hasMatch(value)) {
        return 'Must include number';
      }
      if (value.length < 8) {
        return 'Must be at least 8 characters long';
      }
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final outlineBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Colors.grey),
    );

    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: _validate,
      decoration: InputDecoration(
        hintText: hintText + (requiredField ? ' *' : ''),
        hintStyle: TextStyle(color: AppColors.subtitle),
        border: outlineBorder,
        enabledBorder: outlineBorder,
        focusedBorder: outlineBorder,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
    );
  }
}
