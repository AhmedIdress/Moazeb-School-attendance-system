import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibn_khaldun/auth_and_onboarding_module/data/data_source/local_data_source/hive_data_source.dart';
import 'package:ibn_khaldun/core/constants.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitialState()) {
    //dark = hive.get(AppLocalDataKeys.dark) ?? false;
    //themeMode = dark ? 'Dark' : 'Light';
    /*arabicString = hive.get(AppLocalDataKeys.lang);
    arabic = arabicString == 'Arabic';*/
  }

  HiveDataSource hive = HiveDataSource<bool?>(AppLocalDataKeys.cacheBoxName);
  bool dark = false;
  bool arabic = true;
  bool first = true;
  String themeMode = 'Light';
  String arabicString = 'Arabic';

  void changeTheme() {
    dark = !dark;
    /*hive.set(AppLocalDataKeys.dark, !dark);
    dark = hive.get(AppLocalDataKeys.dark);
    */
    themeMode = dark ? 'Dark' : 'Light';
    /*themeNotifier.value = dark;
    themeNotifier.notifyListeners();
    */
    emit(ThemeState());
  }

  void changeLang() {
    arabic = !arabic;
    //hive.set(AppLocalDataKeys.lang, arabic ? 'Arabic' : 'English');
    //arabic = hive.get(AppLocalDataKeys.lang);
    arabicString = arabic ? 'Arabic' : 'English';
    emit(LangState());
  }
}
