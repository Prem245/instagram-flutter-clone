import 'package:flutter/material.dart';

class TextInputField extends StatelessWidget {
  final bool isPass;
  final String hintText;
  final TextEditingController controller;
  final int maxLines;
  final TextInputType keyboardType;
  const TextInputField(
      {Key? key,
      this.isPass = false,
      required this.hintText,
      required this.controller,
      required this.keyboardType,
      this.maxLines = 1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
    );
    return TextFormField(
      obscureText: isPass,
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(10),
        hintText: hintText,
        border: inputBorder,
        enabledBorder: inputBorder,
        focusedBorder: inputBorder,
        filled: true,
      ),
      keyboardType: keyboardType,
    );
  }
}
