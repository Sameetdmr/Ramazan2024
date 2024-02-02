import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final Widget? suffixIcon;
  final IconData prefixIcon;
  final bool obscureText;
  String? Function(String?)? validator;
  void Function(String)? onChanged;
  CustomTextField({Key? key, required this.textEditingController, required this.onChanged, required this.hintText, required this.prefixIcon, required this.validator, this.obscureText = false, this.suffixIcon = null}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey.shade100,
      ),
      child: TextFormField(
        controller: textEditingController,
        obscureText: obscureText,
        validator: validator,
        onChanged: onChanged,
        textInputAction: TextInputAction.done,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          iconColor: Colors.red,
          hintText: hintText,
          hintStyle: context.textTheme.bodySmall?.copyWith(
            color: Colors.grey,
          ),
          prefixIcon: Icon(
            prefixIcon,
            color: Colors.grey,
          ),
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Colors.grey,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
