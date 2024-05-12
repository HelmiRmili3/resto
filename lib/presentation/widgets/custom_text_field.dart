import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final TextInputAction textInputAction;
  final String? Function(String?)? validator; 
  final TextInputType keyboardType;
  final TextEditingController controller;

  const CustomTextField({
    super.key,
    required this.labelText,
    this.textInputAction = TextInputAction.next,
    required this.validator,
    this.keyboardType = TextInputType.text,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: textInputAction,
      validator: validator,
      decoration: InputDecoration(
        labelText: labelText,
      ),
      keyboardType: keyboardType,
      controller: controller,
    );
  }
}
