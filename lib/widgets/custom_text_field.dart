import 'package:flutter/material.dart';

class customTextField extends StatelessWidget {
  TextEditingController? controller;
  TextStyle? textStyle;
  Function(String)? onSubmitt;
  InputDecoration? decoration;
  customTextField(
      {super.key, this.controller, this.textStyle, this.onSubmitt, this.decoration});

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: controller,
        style: textStyle,
        onSubmitted: onSubmitt,
        decoration: decoration);
  }
}
