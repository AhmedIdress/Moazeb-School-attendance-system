import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibn_khaldun/parent_module/data/models/semi_attendance_model.dart';
import 'package:ibn_khaldun/parent_module/data/parent_repository/parent_repository.dart';
import 'package:ibn_khaldun/parent_module/domain/base_parent_repository/base_parent_repository.dart';
import 'package:ibn_khaldun/teacher_module/data/model/class_children_model.dart';
import 'package:ibn_khaldun/teacher_module/data/teacher_repository/teacher_repository.dart';
import 'package:ibn_khaldun/teacher_module/domain/base_teacher_repository/base_teacher_repository.dart';

part 'classes_state.dart';

class ClassesCubit extends Cubit<ClassesState> {
  ClassesCubit() : super(ClassesInitialState());
  final BaseTeacherRepository _baseTeacherRepository = TeacherRepository();
  final BaseParentRepository _baseParentRepository = ParentRepository();
  late ClassChildrenModel children;
  late SemiAttendanceModel semiAttendanceModel;

  void getData(String className) async {
    emit(ClassesInitialState());
    try {
      children = await _baseTeacherRepository
          .getClassChildren(className.split('_').last);
      if (kDebugMode) {
        print(children);
      }
      getAttend();
      emit(ClassesGetSuccessfullyState());
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      emit(ClassesGetFailedState(e.toString()));
    }
  }

  void getAttend() async {
    emit(ClassesInitialState());
    for (int i = 0; i < children.data!.length; i++) {
      semiAttendanceModel = await _baseParentRepository
          .getStudentAttendanceSemester(children.data?[i].id ?? '');
      children.data?[i].present = semiAttendanceModel.present;
      children.data?[i].absent = semiAttendanceModel.absent;
      children.data?[i].excused = semiAttendanceModel.excused;
    }
    emit(ClassesRefreshState());
  }
}
