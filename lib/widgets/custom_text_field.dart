import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final Widget? suffixIcon;

  const CustomTextField({
    super.key,
    required this.hint,
    required this.controller,
    this.validator,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        hintText: hint,
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.r),
          borderSide: const BorderSide(color: Colors.white),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.r),
          borderSide: const BorderSide(color: Colors.white),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.r),
          borderSide: const BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(32.r),
        ),
        fillColor: Colors.white,
        filled: true,
      ),
      validator: validator,
    );
  }
}
