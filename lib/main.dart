import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ibn_khaldun/auth_and_onboarding_module/data/data_source/local_data_source/hive_data_source.dart';
import 'package:ibn_khaldun/auth_and_onboarding_module/presentation/controllers/boarding/boarding_cubit.dart';
import 'package:ibn_khaldun/auth_and_onboarding_module/presentation/controllers/login/login_cubit.dart';
import 'package:ibn_khaldun/auth_and_onboarding_module/presentation/screens/onboarding/onboarding.dart';
import 'package:ibn_khaldun/core/app_colors.dart';
import 'package:ibn_khaldun/core/app_locale.dart';
import 'package:ibn_khaldun/core/services/dio_helper.dart';
import 'package:ibn_khaldun/parent_module/presentation/controllers/child_cubit/child_cubit.dart';
import 'package:ibn_khaldun/parent_module/presentation/controllers/children_cubit/children_cubit.dart';
import 'package:ibn_khaldun/parent_module/presentation/controllers/custom_calender_cubit/custom_calender_cubit.dart';
import 'package:ibn_khaldun/parent_module/presentation/controllers/profile_cubit/profile_cubit.dart';
import 'package:ibn_khaldun/parent_module/presentation/controllers/study_schedule_cubit/study_schedule_cubit.dart';
import 'package:ibn_khaldun/teacher_module/presentation/controllers/classes_cubit/classes_cubit.dart';

import 'core/constants.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox(AppLocalDataKeys.cacheBoxName);
  DioHelper.init();
  runApp(const MyApp());
}

ValueNotifier<bool> themeNotifier = ValueNotifier(false);

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  HiveDataSource hive = HiveDataSource<bool?>(AppLocalDataKeys.cacheBoxName);

  @override
  Widget build(BuildContext context) {
    /*if (hive.get(AppLocalDataKeys.first) == null) {
      Brightness systemBrightness = MediaQuery.of(context).platformBrightness;
      hive.set(AppLocalDataKeys.dark, systemBrightness == Brightness.dark);
    }
    themeNotifier.value = hive.get(AppLocalDataKeys.dark) ?? false;
*/
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
        BlocProvider(
          create: (BuildContext context) => ChildrenCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => StudyScheduleCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => ProfileCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => ClassesCubit(),
        ),
      ],
      child: ScreenUtilInit(
        builder: (context, widget) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              useMaterial3: true,
              colorScheme: themeNotifier.value
                  ? attendanceDarkColorScheme
                  : attendanceColorScheme,
            ),
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
              /*var cache = HiveDataSource<bool?>(AppLocalDataKeys.cacheBoxName);
              if (cache.get(AppLocalDataKeys.first) == null) {
                if (currentLang != null) {
                  for (Locale locale in supportLang) {
                    if (locale.languageCode == currentLang.languageCode) {
                      cache.set(AppLocalDataKeys.arabic,
                          currentLang.languageCode == 'ar');
                      return currentLang;
                    }
                  }
                }
                cache.set(AppLocalDataKeys.arabic,
                    supportLang.last.languageCode == 'ar');
                cache.set(AppLocalDataKeys.first, false);
                return supportLang.last;
              } else {
                return cache.get(AppLocalDataKeys.arabic) ?? false
                    ? supportLang.first
                    : supportLang.last;
              }*/
              return supportLang.last;
            },
          );
        },
      ),
    );
  }

/*@override
  void initState() {
    themeNotifier.addListener(() {
      setState(() {
        themeNotifier.value = hive.get(AppLocalDataKeys.dark) ?? false;
      });
      print(themeNotifier.value);
    });
    super.initState();
  }*/
}
