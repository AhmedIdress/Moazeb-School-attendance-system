import 'package:flutter/material.dart';
import 'package:ibn_khaldun/auth_and_onboarding_module/presentation/screens/auth/login_screen.dart';
import 'package:ibn_khaldun/core/app_colors.dart';
import 'package:ibn_khaldun/core/app_size.dart';

class AuthLayout extends StatelessWidget {
  const AuthLayout({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height * .31,
              child: Stack(
                children: [
                  Container(
                    height: size.height * .15,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      border: Border.all(
                        width: 0,
                        color: Colors.transparent,
                        style: BorderStyle.none,
                      ),
                      borderRadius: BorderRadiusDirectional.only(
                        bottomEnd: Radius.circular(AppRadius.r80),
                      ),
                    ),
                  ),
                  PositionedDirectional(
                    top: size.height * .149,
                    start: 0,
                    child: Container(
                      padding: EdgeInsets.zero,
                      width: size.width * 0.3,
                      height: size.height * 0.15,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  PositionedDirectional(
                    top: size.height * .15,
                    start: 0,
                    child: Container(
                      width: size.width * 0.31,
                      height: size.height * 0.152,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadiusDirectional.only(
                          topStart: Radius.circular(AppRadius.r80),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSize.s16w,
              ),
              child: const LoginScreen(),
            )
          ],
        ),
      ),
    );
  }
}
