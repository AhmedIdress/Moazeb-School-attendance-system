import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibn_khaldun/core/constants.dart';
import 'package:ibn_khaldun/parent_module/data/models/period_time_mdel.dart';
import 'package:ibn_khaldun/parent_module/data/models/student_schedule_model.dart';
import 'package:ibn_khaldun/parent_module/data/parent_repository/parent_repository.dart';
import 'package:ibn_khaldun/parent_module/domain/base_parent_repository/base_parent_repository.dart';

part 'study_schedule_state.dart';

class StudyScheduleCubit extends Cubit<StudyScheduleState> {
  StudyScheduleCubit() : super(StudyScheduleInitialState());
  final BaseParentRepository _baseParentRepository = ParentRepository();
  late PeriodTimeModel times;
  late StudentScheduleModel scheduleModel;
  late Map<String, dynamic> dayData;
  String day = workDays[0];
  void setDay(String day) {
    this.day = day;
    dayData = scheduleModel.data?[day.toLowerCase()] ?? {};
    emit(StudyScheduleChangeDayState());
  }

  void init(String className) async {
    emit(StudyScheduleInitialState());
    await getData(className);
    dayData = scheduleModel.data?[day.toLowerCase()] ?? {};
    print(dayData);
    emit(GetDataStudyScheduleState());
  }

  Future getData(String className) async {
    var res = await Future.wait([
      _baseParentRepository.getSchedulePeriod(),
      _baseParentRepository.getStudentSchedule(className),
    ]);
    times = res[0] as PeriodTimeModel;
    scheduleModel = res[1] as StudentScheduleModel;
  }
}
