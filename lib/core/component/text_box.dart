import 'package:flutter/material.dart';
import 'package:ibn_khaldun/core/app_size.dart';

class TextBox extends StatelessWidget {
  const TextBox({
    Key? key,
    required this.text,
    required this.controller,
    required this.inputType,
  }) : super(key: key);
  final String text;
  final TextEditingController controller;
  final TextInputType inputType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: AppSize.s2h),
          child: Text(text),
        ),
        TextFormField(
          controller: controller,
          validator: (value) {
            String langCode = Localizations.localeOf(context).languageCode;
            if (value == null || value.isEmpty) {
              if (langCode == 'en') {
                return 'this filed can\'t be empty';
              } else if (langCode == 'ar') {
                return 'لا يمكن ترك الحقل فارغ';
              }
            } else if (!(value.contains('@parent') ||
                value.contains('@teacher'))) {
              if (langCode == 'en') {
                return 'Invalid email';
              } else if (langCode == 'ar') {
                return 'الايميل غير صحيح';
              }
            }
            return null;
          },
          keyboardType: inputType,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.r10),
              ),
              constraints: BoxConstraints(
                maxHeight: AppSize.s48h,
              )),
        ),
      ],
    );
  }
}
