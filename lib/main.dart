import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ibn_khaldun/auth_and_onboarding_module/presentation/controllers/boarding/boarding_cubit.dart';
import 'package:ibn_khaldun/auth_and_onboarding_module/presentation/controllers/login/login_cubit.dart';
import 'package:ibn_khaldun/auth_and_onboarding_module/presentation/screens/onboarding/onboarding.dart';
import 'package:ibn_khaldun/core/app_locale.dart';
import 'package:ibn_khaldun/core/services/dio_helper.dart';
import 'package:ibn_khaldun/core/theme.dart';
import 'package:ibn_khaldun/parent_module/presentation/controllers/child_cubit/child_cubit.dart';
import 'package:ibn_khaldun/parent_module/presentation/controllers/custom_calender_cubit/custom_calender_cubit.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('cacheData');
  DioHelper.init();
  //HiveDataSource.instance.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => LoginCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => CustomCalenderCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => BoardingCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => ChildCubit(),
        ),
      ],
      child: ScreenUtilInit(
        builder: (context, widget) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: themeData,
          home: Onboarding(),
          localizationsDelegates: const [
            AppLocale.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('ar'),
            Locale('en'),
          ],
          localeResolutionCallback: (currentLang, supportLang) {
            /*if (currentLang != null) {
              for (Locale locale in supportLang) {
                if (locale.languageCode == currentLang.languageCode) {
                  return */ /*currentLang*/ /* supportLang.last;
                }
              }
            }*/
            return supportLang.last;
          },
        ),
      ),
    );
  }
}
