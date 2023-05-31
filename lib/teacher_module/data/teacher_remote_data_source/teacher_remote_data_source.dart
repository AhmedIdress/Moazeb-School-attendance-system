import 'package:ibn_khaldun/core/constants.dart';
import 'package:ibn_khaldun/core/services/dio_helper.dart';
import 'package:ibn_khaldun/teacher_module/data/model/class_children_model.dart';
import 'package:ibn_khaldun/teacher_module/data/model/teacher_table_model.dart';

abstract class BaseTeacherRemoteDataSource {
  Future<TeacherTableModel> getTeacherTable(String id);

  Future<ClassChildrenModel> getClassChildren(String className, String token);
}

class TeacherRemoteDataSource extends BaseTeacherRemoteDataSource {
  @override
  Future<TeacherTableModel> getTeacherTable(String id) async {
    try {
      var data = await DioHelper.getData(url: AppEndPoint.getTeacherTable + id);
      print(data.data);
      return TeacherTableModel.fromJson(data.data);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<ClassChildrenModel> getClassChildren(
      String className, String token) async {
    try {
      var data = await DioHelper.getData(
          url: AppEndPoint.classes + className + AppEndPoint.students,
          token: token);
      print(data.data);
      return ClassChildrenModel.fromJson(data.data);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
