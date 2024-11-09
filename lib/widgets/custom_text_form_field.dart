import 'package:flutter/material.dart';

class customTextFormField extends StatelessWidget {
  String? hint;
  Function(String)? onChange;
  bool? obscure;
  TextStyle? textStyle;
  String? Function(String?)? validate;
  customTextFormField(
      {super.key,
      this.textStyle,
      required this.hint,
      this.onChange,
      this.obscure = false,
      this.validate});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: textStyle,
      obscureText: obscure!,
      onChanged: onChange,
      validator: validate,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white)),
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white)),
        hintText: hint,
        hintStyle: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: Colors.white),
      ),
    );
  }
}
