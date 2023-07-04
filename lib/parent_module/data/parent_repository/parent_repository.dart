import 'package:ibn_khaldun/auth_and_onboarding_module/data/data_source/local_data_source/hive_data_source.dart';
import 'package:ibn_khaldun/auth_and_onboarding_module/data/models/login_model.dart';
import 'package:ibn_khaldun/core/constants.dart';
import 'package:ibn_khaldun/parent_module/data/models/logs_model.dart';
import 'package:ibn_khaldun/parent_module/data/models/month_attendance_model.dart';
import 'package:ibn_khaldun/parent_module/data/models/period_time_mdel.dart';
import 'package:ibn_khaldun/parent_module/data/models/semi_attendance_model.dart';
import 'package:ibn_khaldun/parent_module/data/models/student_model.dart';
import 'package:ibn_khaldun/parent_module/data/models/student_schedule_model.dart';
import 'package:ibn_khaldun/parent_module/data/remote_data_source/parent_remote_data_source.dart';
import 'package:ibn_khaldun/parent_module/domain/base_parent_repository/base_parent_repository.dart';

class ParentRepository extends BaseParentRepository {
  final BaseParentRemoteDataSource _baseParentRemoteDataSource =
      ParentRemoteDataSource();

  @override
  Future<MonthAttendanceModel> getStudentAttendanceMonth(
      String id, int month) async {
    var model =
        await _baseParentRemoteDataSource.getStudentAttendanceMonth(id, month);
    return model;
  }

  @override
  Future<SemiAttendanceModel> getStudentAttendanceSemester(String id) async {
    var data =
        await _baseParentRemoteDataSource.getStudentAttendanceSemester(id);
    return data;
  }

  @override
  Future<LoginData> getParentLoinData() async {
    HiveDataSource hive =
        HiveDataSource<Map<String, dynamic>>(AppLocalDataKeys.cacheBoxName);
    Map<String, dynamic> data = hive.get(AppLocalDataKeys.parent);
    print(data);
    return LoginData.fromJson(data);
  }

  @override
  Future<StudentModel> getStudentData(String id) async {
    HiveDataSource hive = HiveDataSource<String>(AppLocalDataKeys.cacheBoxName);
    String token = hive.get(AppLocalDataKeys.token);
    var data = await _baseParentRemoteDataSource.getStudentData(id, token);
    return data;
  }

  @override
  Future<PeriodTimeModel> getSchedulePeriod() async {
    return await _baseParentRemoteDataSource.getSchedulePeriod();
  }

  @override
  Future<StudentScheduleModel> getStudentSchedule(String className) async {
    return await _baseParentRemoteDataSource.getStudentSchedule(className);
  }

  @override
  Future<List<LogModel>> getLogs(String id) async {
    return await _baseParentRemoteDataSource.getLogs(id);
  }
}
