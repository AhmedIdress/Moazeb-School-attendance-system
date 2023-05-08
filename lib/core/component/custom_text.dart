import 'package:flutter/material.dart';
import 'package:ibn_khaldun/core/app_size.dart';

class CustomText extends StatelessWidget {
  const CustomText(
      {Key? key,
      required this.text,
      this.color,
      this.fontWeight,
      this.fontSize})
      : super(key: key);
  final String text;
  final Color? color;
  final FontWeight? fontWeight;
  final double? fontSize;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        //color: color?? AppColors.black,
        fontSize: fontSize ?? AppFont.f14,
        fontWeight: fontWeight ?? FontWeight.normal,
      ),
    );
  }
}
