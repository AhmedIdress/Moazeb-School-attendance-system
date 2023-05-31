import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibn_khaldun/core/constants.dart';
import 'package:ibn_khaldun/parent_module/data/models/period_time_mdel.dart';
import 'package:ibn_khaldun/parent_module/data/parent_repository/parent_repository.dart';
import 'package:ibn_khaldun/parent_module/domain/base_parent_repository/base_parent_repository.dart';
import 'package:ibn_khaldun/teacher_module/data/model/teacher_table_model.dart';
import 'package:ibn_khaldun/teacher_module/data/teacher_repository/teacher_repository.dart';
import 'package:ibn_khaldun/teacher_module/domain/base_teacher_repository/base_teacher_repository.dart';
import 'package:translator/translator.dart';

part 'teacher_state.dart';

class TeacherCubit extends Cubit<TeacherState> {
  TeacherCubit() : super(TeacherInitialState()) {
    getTable();
  }

  final BaseTeacherRepository _baseTeacherRepository = TeacherRepository();
  final BaseParentRepository _baseParentRepository = ParentRepository();
  late TeacherTableModel table;
  late PeriodTimeModel times;
  List<TeacherTable> tablesDay = [];

  String day = workDays[0];

  void setDay(String day) {
    emit(TeacherInitialState());
    this.day = day;
    filterDay();
    emit(TeacherTableDayState());
  }

  void filterDay() {
    tablesDay = [];
    table.data?.forEach((element) {
      if (element.day.toLowerCase() == day.toLowerCase()) {
        tablesDay.add(element);
      }
    });
  }

  void getTable() async {
    emit(TeacherInitialState());
    var get = await Future.wait([
      _baseParentRepository.getSchedulePeriod(),
      _baseTeacherRepository.getTeacherTable()
    ]);
    times = get[0] as PeriodTimeModel;
    table = get[1] as TeacherTableModel;
    filterDay();
    emit(GetTeacherTableState());
  }

  void init(String lang) {
    emit(TeacherInitialState());
    lang == 'ar' ? trans() : getTable();
    emit(GetTeacherTableState());
  }

  void trans() async {
    emit(TeacherInitialState());
    var translator = GoogleTranslator();
    for (int i = 0; i < table.data!.length; i++) {
      var tran = await translator.translate(table.data?[i].subjectName ?? '',
          from: 'en', to: 'ar');
      table.data?[i].subjectName = tran.text;
      emit(TransTeacherScheduleState());
    }
  }
}
