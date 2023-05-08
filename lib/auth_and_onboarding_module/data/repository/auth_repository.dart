import 'package:ibn_khaldun/auth_and_onboarding_module/data/data_source/remote_data_source/remote_data_source.dart';
import 'package:ibn_khaldun/auth_and_onboarding_module/data/models/login_model.dart';
import 'package:ibn_khaldun/auth_and_onboarding_module/domain/repository/base_auth_repository.dart';

class AuthRepository extends BaseAuthRepository {
  late BaseAuthRemoteDataSource _baseAuthRemoteDataSource;
  @override
  Future<LoginModel> login(String email, String password) async {
    _baseAuthRemoteDataSource = AuthRemoteDataSource();
    LoginModel loginModel =
        await _baseAuthRemoteDataSource.login(email, password);
    return loginModel;
  }
}
