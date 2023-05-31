import 'package:ibn_khaldun/auth_and_onboarding_module/data/data_source/local_data_source/hive_data_source.dart';
import 'package:ibn_khaldun/auth_and_onboarding_module/data/models/login_teacher_model.dart';
import 'package:ibn_khaldun/core/constants.dart';
import 'package:ibn_khaldun/teacher_module/data/model/class_children_model.dart';
import 'package:ibn_khaldun/teacher_module/data/model/teacher_table_model.dart';
import 'package:ibn_khaldun/teacher_module/data/teacher_remote_data_source/teacher_remote_data_source.dart';
import 'package:ibn_khaldun/teacher_module/domain/base_teacher_repository/base_teacher_repository.dart';

class TeacherRepository extends BaseTeacherRepository {
  final BaseTeacherRemoteDataSource _baseTeacherRemoteDataSource =
      TeacherRemoteDataSource();

  @override
  Future<TeacherTableModel> getTeacherTable() async {
    var hive =
        HiveDataSource<Map<String, dynamic>>(AppLocalDataKeys.cacheBoxName);
    TeacherData teacherModel = TeacherData.fromJson(
      hive.get(AppLocalDataKeys.teacher),
    );
    return await _baseTeacherRemoteDataSource.getTeacherTable(teacherModel.id);
  }

  @override
  Future<ClassChildrenModel> getClassChildren(String className) async {
    var hive = HiveDataSource<String>(AppLocalDataKeys.cacheBoxName);

    return await _baseTeacherRemoteDataSource.getClassChildren(
        className, hive.get(AppLocalDataKeys.tokenTeacher));
  }
}
