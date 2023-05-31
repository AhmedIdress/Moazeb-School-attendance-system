import 'package:flutter/material.dart';
import 'package:ibn_khaldun/auth_and_onboarding_module/presentation/screens/auth/login_screen.dart';
import 'package:ibn_khaldun/core/app_colors.dart';
import 'package:ibn_khaldun/core/app_size.dart';
import 'package:ibn_khaldun/core/extensions_helper.dart';

class AuthLayout extends StatelessWidget {
  const AuthLayout({super.key});

  @override
  Widget build(BuildContext context) {
    var height = context.screenHeight;
    var width = context.screenWidth;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: height * .31,
              child: Stack(
                children: [
                  Container(
                    height: height * .15,
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
                    top: height * .149,
                    start: 0,
                    child: Container(
                      padding: EdgeInsets.zero,
                      width: width * 0.3,
                      height: height * 0.15,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  PositionedDirectional(
                    top: height * .15,
                    start: 0,
                    child: Container(
                      width: width * 0.31,
                      height: height * 0.152,
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
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
