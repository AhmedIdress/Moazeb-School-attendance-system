import 'package:ibn_khaldun/auth_and_onboarding_module/data/data_source/local_data_source/hive_data_source.dart';
import 'package:ibn_khaldun/auth_and_onboarding_module/data/models/login_model.dart';
import 'package:ibn_khaldun/core/constants.dart';
import 'package:ibn_khaldun/parent_module/domain/base_parent_repository/base_parent_repository.dart';

class ParentRepository extends BaseParentRepository {
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

  @override
  Future<LoginData> getParentLoinData() async {
    Map<String, dynamic> data =
        HiveDataSource.instance.get(AppLocalDataKeys.parent);
    print(data);
    return LoginData.fromJson(data);
  }
}
