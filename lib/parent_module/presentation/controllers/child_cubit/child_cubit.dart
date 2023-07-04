import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibn_khaldun/core/app_path.dart';
import 'package:ibn_khaldun/parent_module/data/models/card_style_model.dart';
import 'package:ibn_khaldun/parent_module/data/models/logs_model.dart';
import 'package:ibn_khaldun/parent_module/data/models/semi_attendance_model.dart';
import 'package:ibn_khaldun/parent_module/data/models/student_model.dart';
import 'package:ibn_khaldun/parent_module/data/parent_repository/parent_repository.dart';
import 'package:ibn_khaldun/parent_module/domain/base_parent_repository/base_parent_repository.dart';

part 'child_state.dart';

class ChildCubit extends Cubit<ChildState> {
  ChildCubit() : super(ChildInitialState());
  final BaseParentRepository _baseParentRepository = ParentRepository();
  late SemiAttendanceModel semiAttendanceModel;
  late StudentModel studentModel;
  late List<LogModel> logs;

  void init(String id) {
    getData(id);
  }

  void getData(String id) async {
    List list = await Future.wait([
      _baseParentRepository.getStudentAttendanceSemester(id),
      _baseParentRepository.getStudentData(id)
    ]);
    semiAttendanceModel = list.first;
    studentModel = list.last;
    if (semiAttendanceModel.succeeded && studentModel.succeeded) {
      fill();
      emit(GetDataSuccessfullyState());
    } else {
      emit(GetSemiAttendanceFailedState(
          '${semiAttendanceModel.message}, ${semiAttendanceModel.errors}'));
    }
  }

  void getLogs(String id) async {
    emit(LogsInitialState());
    logs = await _baseParentRepository.getLogs(id);
    emit(LogsState());
  }

  void fill() {
    cards = [
      CardStyleModel(
        state: 'attendDay',
        backgroundColor: const Color.fromRGBO(255, 118, 72, 1),
        maskColor: const Color.fromRGBO(255, 194, 120, 1),
        icon: AppPath.success,
        days: semiAttendanceModel.present,
      ),
      CardStyleModel(
        state: 'excuseDay',
        backgroundColor: const Color.fromRGBO(143, 152, 255, 1),
        maskColor: const Color.fromRGBO(24, 42, 136, 1),
        icon: AppPath.subtract,
        days: semiAttendanceModel.excused,
      ),
      CardStyleModel(
        state: 'absentDay',
        backgroundColor: const Color.fromRGBO(255, 194, 120, 1),
        maskColor: const Color.fromRGBO(255, 118, 72, 1),
        icon: AppPath.wrong,
        days: semiAttendanceModel.absent,
      )
    ];
  }

  List<CardStyleModel> cards = [];
  List<CardStyleModel> scheduleAndLogs = [
    CardStyleModel(
      state: 'schedule',
      backgroundColor: const Color.fromRGBO(77, 197, 145, 1),
      maskColor: const Color.fromRGBO(0, 102, 79, 1),
      icon: AppPath.notes,
      days: 0,
    ),
    CardStyleModel(
      state: 'logs',
      backgroundColor: Colors.black.withGreen(200),
      maskColor: Colors.black.withRed(210),
      icon: AppPath.list,
      days: 0,
    ),
  ];
}
