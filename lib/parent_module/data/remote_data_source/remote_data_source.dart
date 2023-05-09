abstract class BaseRemoteDataSource {
  Future getStudentAttendanceSemester(String id);
  Future getStudentAttendanceMonth(String id);
  Future getStudentSchedule(String id);
}

class RemoteDataSource extends BaseRemoteDataSource {
  @override
  Future getStudentAttendanceMonth(String id) async {
    // TODO: implement getStudentAttendanceMonth
    throw UnimplementedError();
  }

  @override
  Future getStudentAttendanceSemester(String id) async {
    // TODO: implement getStudentAttendanceSemester
    throw UnimplementedError();
  }

  @override
  Future getStudentSchedule(String id) async {
    // TODO: implement getStudentSchedule
    throw UnimplementedError();
  }
}
