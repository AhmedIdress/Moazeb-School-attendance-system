import 'package:flutter/material.dart';
import 'package:ibn_khaldun/auth_and_onboarding_module/presentation/screens/auth/login_screen.dart';
import 'package:ibn_khaldun/core/app_size.dart';

class AuthLayout extends StatefulWidget {
  const AuthLayout({Key? key}) : super(key: key);

  @override
  State<AuthLayout> createState() => _AuthLayoutState();
}

class _AuthLayoutState extends State<AuthLayout> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSize.s16w,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CircleAvatar(
                radius: AppRadius.r40,
              ),
              LoginScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
