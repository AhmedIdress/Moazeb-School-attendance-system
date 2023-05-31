import 'package:ibn_khaldun/teacher_module/data/model/class_children_model.dart';
import 'package:ibn_khaldun/teacher_module/data/model/teacher_table_model.dart';

abstract class BaseTeacherRepository {
  Future<TeacherTableModel> getTeacherTable();

  Future<ClassChildrenModel> getClassChildren(String className);
}
