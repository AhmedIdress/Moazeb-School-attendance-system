import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibn_khaldun/auth_and_onboarding_module/data/data_source/local_data_source/hive_data_source.dart';
import 'package:ibn_khaldun/auth_and_onboarding_module/data/models/login_model.dart';
import 'package:ibn_khaldun/auth_and_onboarding_module/data/models/login_teacher_model.dart';
import 'package:ibn_khaldun/core/constants.dart';
import 'package:ibn_khaldun/main.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> with ChangeNotifier {
  ProfileCubit() : super(ProfileInitialState()) {
    dark = hive.get(AppLocalDataKeys.dark) ?? false;
    //themeMode = dark ? 'Dark' : 'Light';
    arabic = hive.get(AppLocalDataKeys.arabic) ?? false;
    // arabicString = arabic ? 'Arabic' : "English";
    getData();
  }

  HiveDataSource hive = HiveDataSource<bool?>(AppLocalDataKeys.cacheBoxName);
  HiveDataSource hiveMap =
      HiveDataSource<Map<String, dynamic>>(AppLocalDataKeys.cacheBoxName);
  late bool isParent;

  bool dark = false;
  bool arabic = false;

  //String themeMode = 'Light';
  //String arabicString = 'Arabic';
  late LoginData parent;
  late TeacherData teacher;

  void changeTheme() {
    hive.set(AppLocalDataKeys.dark, !dark);
    dark = hive.get(AppLocalDataKeys.dark);
    // themeMode = dark ? 'Dark' : 'Light';
    themeNotifier.value = dark;
    themeNotifier.notifyListeners();
    emit(ThemeState());
  }

  void changeLang() {
    hive.set(AppLocalDataKeys.arabic, !arabic);
    arabic = hive.get(AppLocalDataKeys.arabic);
    // arabicString = arabic ? 'Arabic' : 'English';
    arabicNotifier.value = arabic;
    arabicNotifier.notifyListeners();
    emit(LangState());
  }

  void getData() {
    emit(ProfileInitialState());
    isParent = hive.get(AppLocalDataKeys.isParent);
    print(isParent);
    if (isParent) {
      parent = LoginData.fromJson(hiveMap.get(AppLocalDataKeys.parent));
    } else {
      teacher = TeacherData.fromJson(hiveMap.get(AppLocalDataKeys.teacher));
    }
    emit(ProfileDataState());
  }
}
