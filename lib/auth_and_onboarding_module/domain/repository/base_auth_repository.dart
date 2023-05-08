import 'package:ibn_khaldun/auth_and_onboarding_module/data/models/login_model.dart';

abstract class BaseAuthRepository {
  Future<LoginModel> login(String email, String password);
}
