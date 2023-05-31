import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibn_khaldun/auth_and_onboarding_module/data/data_source/local_data_source/hive_data_source.dart';
import 'package:ibn_khaldun/auth_and_onboarding_module/data/repository/auth_repository.dart';
import 'package:ibn_khaldun/auth_and_onboarding_module/domain/repository/base_auth_repository.dart';
import 'package:ibn_khaldun/auth_and_onboarding_module/presentation/controllers/login/login_state.dart';
import 'package:ibn_khaldun/core/constants.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(InitialLoginState());
  final BaseAuthRepository _baseAuthRepository = AuthRepository();

  void login(String email, String password) async {
    emit(WaitingLoginState());
    if (email.contains('@parent')) {
      try {
        var login = await _baseAuthRepository.login(email, password);
        if (login.succeeded) {
          HiveDataSource hiveMap = HiveDataSource<Map<String, dynamic>>(
              AppLocalDataKeys.cacheBoxName);
          HiveDataSource hiveString =
              HiveDataSource<String>(AppLocalDataKeys.cacheBoxName);
          hiveString.set(AppLocalDataKeys.token, login.token);

          hiveMap.set(AppLocalDataKeys.parent, login.data?.toJson() ?? {});
          emit(LoginSuccessfullyState(login.message, true));
        } else {
          emit(
            LoginFailedState('${login.message} ${login.errors}'),
          );
        }
      } on Exception catch (e) {
        emit(
          LoginFailedState(e.toString()),
        );
      }
    } else {
      loginTeacher(email, password);
    }
  }

  void loginTeacher(String email, String password) async {
    try {
      var data = await _baseAuthRepository.loginTeacher(email, password);
      if (data.succeeded) {
        HiveDataSource hiveMap =
            HiveDataSource<Map<String, dynamic>>(AppLocalDataKeys.cacheBoxName);
        HiveDataSource hiveString =
            HiveDataSource<String>(AppLocalDataKeys.cacheBoxName);
        hiveString.set(AppLocalDataKeys.tokenTeacher, data.token);

        hiveMap.set(AppLocalDataKeys.teacher, data.data?.toJson());

        emit(LoginSuccessfullyState(data.message, false));
      } else {
        emit(
          LoginFailedState('${data.message} ${data.errors}'),
        );
      }
    } on Exception catch (e) {
      emit(
        LoginFailedState(e.toString()),
      );
    }
  }
}
