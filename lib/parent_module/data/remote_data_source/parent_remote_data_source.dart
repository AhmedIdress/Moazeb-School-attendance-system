import 'package:ibn_khaldun/core/constants.dart';
import 'package:ibn_khaldun/core/services/dio_helper.dart';
import 'package:ibn_khaldun/parent_module/data/models/month_attendace_model.dart';
import 'package:ibn_khaldun/parent_module/data/models/semi_attendance_model.dart';
import 'package:ibn_khaldun/parent_module/data/models/student_model.dart';

abstract class BaseParentRemoteDataSource {
  Future<SemiAttendanceModel> getStudentAttendanceSemester(String id);
  Future<MonthAttendanceModel> getStudentAttendanceMonth(String id, int month);
  Future getStudentSchedule(String id);
  Future<StudentModel> getStudentData(String id, String token);
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
  Future getStudentSchedule(String id) async {
    // TODO: implement getStudentSchedule
    throw UnimplementedError();
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
}