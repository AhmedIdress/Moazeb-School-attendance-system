import 'package:ibn_khaldun/auth_and_onboarding_module/data/data_source/remote_data_source/auth_remote_data_source.dart';
import 'package:ibn_khaldun/auth_and_onboarding_module/data/models/login_model.dart';
import 'package:ibn_khaldun/auth_and_onboarding_module/data/models/login_teacher_model.dart';
import 'package:ibn_khaldun/auth_and_onboarding_module/domain/repository/base_auth_repository.dart';

class AuthRepository extends BaseAuthRepository {
  final BaseAuthRemoteDataSource _baseAuthRemoteDataSource =
      AuthRemoteDataSource();

  @override
  Future<LoginModel> login(String email, String password) async {
    LoginModel loginModel =
        await _baseAuthRemoteDataSource.login(email, password);
    return loginModel;
  }

  @override
  Future<LoginTeacherModel> loginTeacher(String email, String password) async {
    return await _baseAuthRemoteDataSource.loginTeacher(email, password);
  }
}
