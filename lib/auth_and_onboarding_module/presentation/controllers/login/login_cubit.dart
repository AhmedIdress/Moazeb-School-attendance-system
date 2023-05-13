import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibn_khaldun/auth_and_onboarding_module/data/data_source/local_data_source/hive_data_source.dart';
import 'package:ibn_khaldun/auth_and_onboarding_module/data/repository/auth_repository.dart';
import 'package:ibn_khaldun/auth_and_onboarding_module/domain/repository/base_auth_repository.dart';
import 'package:ibn_khaldun/auth_and_onboarding_module/presentation/controllers/login/login_state.dart';
import 'package:ibn_khaldun/core/constants.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(InitialLoginState());
  late BaseAuthRepository _baseAuthRepository;
  void login(String email, String password) async {
    _baseAuthRepository = AuthRepository();
    try {
      var login = await _baseAuthRepository.login(email, password);
      if (login.succeeded) {
        HiveDataSource hiveMap =
            HiveDataSource<Map<String, dynamic>>(AppLocalDataKeys.cacheBoxName);
        HiveDataSource hiveString =
            HiveDataSource<String>(AppLocalDataKeys.cacheBoxName);
        hiveString.set(AppLocalDataKeys.token, login.token);
        hiveMap.set(AppLocalDataKeys.parent, login.data?.toJson() ?? {});
        emit(LoginSuccessfullyState(login.message));
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
  }
}
