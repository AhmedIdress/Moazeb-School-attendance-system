import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibn_khaldun/core/constants.dart';
import 'package:ibn_khaldun/parent_module/data/models/period_time_mdel.dart';
import 'package:ibn_khaldun/parent_module/data/models/student_schedule_model.dart';
import 'package:ibn_khaldun/parent_module/data/parent_repository/parent_repository.dart';
import 'package:ibn_khaldun/parent_module/domain/base_parent_repository/base_parent_repository.dart';
import 'package:translator/translator.dart';

part 'study_schedule_state.dart';

class StudyScheduleCubit extends Cubit<StudyScheduleState> {
  StudyScheduleCubit() : super(StudyScheduleInitialState());
  final BaseParentRepository _baseParentRepository = ParentRepository();
  late PeriodTimeModel times;
  late StudentScheduleModel scheduleModel;
  late Map<String, dynamic> dayData;
  String day = workDays[0];

  void setDay(String day) async {
    emit(StudyScheduleInitialState());
    this.day = day;
    dayData = scheduleModel.data?[day.toLowerCase()] ?? {};
    emit(StudyScheduleChangeDayState());
  }

  void init(String className, String lang) async {
    emit(StudyScheduleInitialState());
    await getData(className);
    lang == 'ar' ? trans() : getData(className);
    day = workDays[0];
    dayData = scheduleModel.data?[day.toLowerCase()] ?? {};
    emit(GetDataStudyScheduleState());
  }

  void trans() {
    emit(StudyScheduleInitialState());
    var translator = GoogleTranslator();
    workDays.forEach((element) async {
      Map<String, dynamic>? map = scheduleModel.data?[element.toLowerCase()];
      for (int i = 0; i < times.period!.length; i++) {
        print(map?[times.period?[i]?.name.toLowerCase() ?? '']);
        var tran = await translator.translate(
            map?[times.period?[i]?.name.toLowerCase()].toString() ?? '',
            from: 'en',
            to: 'ar');
        map?[times.period?[i]?.name.toLowerCase() ?? ''] = tran.text;
        print(map?[times.period?[i]?.name.toLowerCase() ?? '']);
        emit(TransDataStudyScheduleState());
      }
      scheduleModel.data?[element] = map ?? {};
    });
  }

  Future<void> getData(String className) async {
    var res = await Future.wait([
      _baseParentRepository.getSchedulePeriod(),
      _baseParentRepository.getStudentSchedule(className),
    ]);
    times = res[0] as PeriodTimeModel;
    scheduleModel = res[1] as StudentScheduleModel;
  }
}
