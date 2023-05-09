import 'package:ibn_khaldun/auth_and_onboarding_module/data/models/login_model.dart';

abstract class BaseParentRepository {
  Future getStudentAttendanceSemester(String id);
  Future getStudentAttendanceMonth(String id);
  Future getStudentSchedule(String id);
  Future<LoginData> getParentLoinData();
}
