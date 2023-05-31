import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibn_khaldun/teacher_module/data/model/class_children_model.dart';
import 'package:ibn_khaldun/teacher_module/data/teacher_repository/teacher_repository.dart';
import 'package:ibn_khaldun/teacher_module/domain/base_teacher_repository/base_teacher_repository.dart';

part 'classes_state.dart';

class ClassesCubit extends Cubit<ClassesState> {
  ClassesCubit() : super(ClassesInitialState());
  final BaseTeacherRepository _baseTeacherRepository = TeacherRepository();
  late ClassChildrenModel children;

  void getData(String className) async {
    emit(ClassesInitialState());
    try {
      children = await _baseTeacherRepository.getClassChildren(className);
      emit(ClassesGetSuccessfullyState());
    } catch (e) {
      print(e);
      emit(ClassesGetFailedState());
    }
  }
}
