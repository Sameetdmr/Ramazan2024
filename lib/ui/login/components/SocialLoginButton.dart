// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SocialLoginButton extends StatelessWidget {
  const SocialLoginButton({
    Key? key,
    required this.onTap,
    required this.imageUrl,
  }) : super(key: key);
  final void Function() onTap;
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 30.w,
        height: 30.h,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage(imageUrl),
          fit: BoxFit.cover,
        )),
      ),
    );
  }
}
