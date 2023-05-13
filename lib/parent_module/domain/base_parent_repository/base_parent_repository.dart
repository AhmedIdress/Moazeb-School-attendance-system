import 'package:ibn_khaldun/auth_and_onboarding_module/data/models/login_model.dart';
import 'package:ibn_khaldun/parent_module/data/models/month_attendace_model.dart';
import 'package:ibn_khaldun/parent_module/data/models/semi_attendance_model.dart';
import 'package:ibn_khaldun/parent_module/data/models/student_model.dart';

abstract class BaseParentRepository {
  Future<SemiAttendanceModel> getStudentAttendanceSemester(String id);
  Future<MonthAttendanceModel> getStudentAttendanceMonth(String id, int month);
  Future getStudentSchedule(String id);
  Future<LoginData> getParentLoinData();
  Future<StudentModel> getStudentData(String id);
}
