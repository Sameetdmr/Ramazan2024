import 'package:flutter/material.dart';
import 'package:ramadan/utils/constants/color_constant.dart';
import 'package:ramadan/utils/theme/CustomTextTheme.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({required this.textEditingController, required this.onChanged, required this.hintText, required this.prefixIcon, required this.validator, super.key, this.obscureText = false, this.suffixIcon});
  final TextEditingController textEditingController;
  final String hintText;
  final Widget? suffixIcon;
  final IconData prefixIcon;
  final bool obscureText;
  String? Function(String?)? validator;
  void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: ColorCommonConstant.greyShade100,
      ),
      child: TextFormField(
        controller: textEditingController,
        obscureText: obscureText,
        validator: validator,
        onChanged: onChanged,
        textInputAction: TextInputAction.done,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          iconColor: ColorCommonConstant.red,
          hintText: hintText,
          hintStyle: CustomTextTheme(context).bodySmall.copyWith(
                color: ColorCommonConstant.grey,
              ),
          prefixIcon: Icon(
            prefixIcon,
            color: ColorCommonConstant.grey,
          ),
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: ColorCommonConstant.grey,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: ColorCommonConstant.white,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: ColorCommonConstant.grey,
            ),
          ),
        ),
      ),
    );
  }
}
