import 'package:ibn_khaldun/core/constants.dart';
import 'package:ibn_khaldun/core/services/dio_helper.dart';
import 'package:ibn_khaldun/parent_module/data/models/logs_model.dart';
import 'package:ibn_khaldun/parent_module/data/models/month_attendance_model.dart';
import 'package:ibn_khaldun/parent_module/data/models/period_time_mdel.dart';
import 'package:ibn_khaldun/parent_module/data/models/semi_attendance_model.dart';
import 'package:ibn_khaldun/parent_module/data/models/student_model.dart';
import 'package:ibn_khaldun/parent_module/data/models/student_schedule_model.dart';

abstract class BaseParentRemoteDataSource {
  Future<SemiAttendanceModel> getStudentAttendanceSemester(String id);

  Future<MonthAttendanceModel> getStudentAttendanceMonth(String id, int month);

  Future<StudentScheduleModel> getStudentSchedule(String className);

  Future<PeriodTimeModel> getSchedulePeriod();

  Future<StudentModel> getStudentData(String id, String token);

  Future<List<LogModel>> getLogs(
    String id,
  );
}

class ParentRemoteDataSource extends BaseParentRemoteDataSource {
  @override
  Future<MonthAttendanceModel> getStudentAttendanceMonth(
      String id, int month) async {
    var response = await DioHelper.postData(
        url: AppEndPoint.attendMonth, data: {"studentId": id, "month": month});
    if (response.statusCode == 200) {
      print(response.data);
      return MonthAttendanceModel.fromJson(response.data);
    } else {
      throw Exception('response error');
    }
  }

  @override
  Future<SemiAttendanceModel> getStudentAttendanceSemester(String id) async {
    var response =
        await DioHelper.getData(url: AppEndPoint.attendSemester + id);
    if (response.statusCode == 200) {
      print(response.data);
      return SemiAttendanceModel.fromJson(response.data);
    } else {
      throw Exception('response error');
    }
  }

  @override
  Future<StudentScheduleModel> getStudentSchedule(String className) async {
    var response = await DioHelper.getData(
      url: AppEndPoint.getStudentSchedule + className,
    );
    if (response.statusCode == 200) {
      print(response.data);
      return StudentScheduleModel.fromJson(response.data);
    } else {
      throw Exception('response error');
    }
  }

  @override
  Future<StudentModel> getStudentData(String id, String token) async {
    var response = await DioHelper.getData(
      url: AppEndPoint.getStudent + id,
      token: token,
    );
    if (response.statusCode == 200) {
      print(response.data);
      return StudentModel.fromJson(response.data);
    } else {
      throw Exception('response error');
    }
  }

  @override
  Future<PeriodTimeModel> getSchedulePeriod() async {
    var response = await DioHelper.getData(
      url: AppEndPoint.getTimes,
    );
    if (response.statusCode == 200) {
      print(response.data);
      return PeriodTimeModel.fromJson(response.data);
    } else {
      throw Exception('response error');
    }
  }

  @override
  Future<List<LogModel>> getLogs(String id) async {
    var response = await DioHelper.getData(
      url: AppEndPoint.attendance + id + AppEndPoint.logs,
    );
    if (response.statusCode == 200) {
      print(response.data['data']);
      List maps = response.data['data'];
      List<LogModel> logs = [];
      maps.forEach((element) {
        logs.add(
          LogModel.fromJson((element as Map<String, dynamic>)),
        );
      });
      return logs;
    } else {
      throw Exception('response error');
    }
  }
}
