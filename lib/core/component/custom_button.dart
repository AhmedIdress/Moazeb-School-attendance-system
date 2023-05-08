import 'package:flutter/material.dart';
import 'package:ibn_khaldun/core/app_size.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.text,
    this.onPressed,
  }) : super(key: key);
  final String text;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: ButtonStyle(
          minimumSize: MaterialStateProperty.all<Size?>(
            Size(
              double.infinity,
              AppSize.s42h,
            ),
          ),
          shape: MaterialStateProperty.all<OutlinedBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.r10)))),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
