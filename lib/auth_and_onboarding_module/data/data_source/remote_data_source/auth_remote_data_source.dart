import 'package:ibn_khaldun/auth_and_onboarding_module/data/models/login_model.dart';
import 'package:ibn_khaldun/auth_and_onboarding_module/data/models/login_teacher_model.dart';
import 'package:ibn_khaldun/core/constants.dart';
import 'package:ibn_khaldun/core/services/dio_helper.dart';

abstract class BaseAuthRemoteDataSource {
  Future<LoginModel> login(String email, String password);

  Future<LoginTeacherModel> loginTeacher(String email, String password);
}

class AuthRemoteDataSource extends BaseAuthRemoteDataSource {
  @override
  Future<LoginModel> login(String email, String password) async {
    var response = await DioHelper.postData(
        url: AppEndPoint.login, data: {"Email": email, "Password": password});
    print(response.realUri);
    if (response.statusCode == 200) {
      var data = response.data;
      return LoginModel.fromJson(data);
    } else {
      throw Exception('response error');
    }
  }

  @override
  Future<LoginTeacherModel> loginTeacher(String email, String password) async {
    var response = await DioHelper.postData(
        url: AppEndPoint.login, data: {"Email": email, "Password": password});
    if (response.statusCode == 200) {
      var data = response.data;
      return LoginTeacherModel.fromJson(data);
    } else {
      throw Exception('response error');
    }
  }
}
