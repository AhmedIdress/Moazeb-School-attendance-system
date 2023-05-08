import 'package:flutter/material.dart';
import 'package:ibn_khaldun/core/app_locale.dart';
import 'package:ibn_khaldun/core/app_size.dart';

class PasswordBox extends StatefulWidget {
  const PasswordBox({
    Key? key,
    required this.controller,
    this.confirm = false,
  }) : super(key: key);
  final TextEditingController controller;
  final bool confirm;
  @override
  State<PasswordBox> createState() => _PasswordBoxState();
}

class _PasswordBoxState extends State<PasswordBox> {
  bool iconVisible = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: AppSize.s2h),
          child: Text(/*'${widget.confirm?'تاكيد ':''}كلمة المرور'*/ getLang(
              context, 'password')),
        ),
        TextFormField(
          controller: widget.controller,
          validator: (value) {
            String langCode = Localizations.localeOf(context).languageCode;
            if (value == null || value.isEmpty) {
              if (langCode == 'ar') {
                return 'لا يمكن ترك الحقل فارغ';
              } else if (langCode == 'en') {
                return 'Password is required';
              }
            } else if (value.length < 8) {
              if (langCode == 'ar') {
                return 'كلمة المرور يجب ان تكون بطول 6 احرف او اكثر';
              } else if (langCode == 'en') {
                return 'Password length should be 8 or more';
              }
            }
            return null;
          },
          keyboardType: TextInputType.visiblePassword,
          obscureText: iconVisible,
          decoration: InputDecoration(
              suffixIcon: InkWell(
                  onTap: () {
                    iconVisible = !iconVisible;
                    setState(() {});
                  },
                  child: Icon(
                      iconVisible ? Icons.visibility_off : Icons.visibility)),
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
