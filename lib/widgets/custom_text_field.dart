import 'package:flutter/material.dart';

class customTextFormField extends StatelessWidget {
  String? hint;
  Function(String)? onChange;
  bool? obscure;
  customTextFormField(
      {super.key, required this.hint, this.onChange, this.obscure = false});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      obscureText: obscure!,
      onChanged: onChange,
      validator: (data) {
        if (data!.isEmpty) {
          return 'value is empty';
        }
      },
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white)),
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white)),
        hintText: hint,
        hintStyle: Theme.of(context)
            .textTheme
            .bodyText1!
            .copyWith(color: Colors.white),
      ),
    );
  }
}
