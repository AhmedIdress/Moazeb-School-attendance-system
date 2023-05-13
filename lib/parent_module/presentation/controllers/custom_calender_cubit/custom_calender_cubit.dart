import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibn_khaldun/parent_module/data/models/day_state_model.dart';
import 'package:ibn_khaldun/parent_module/data/models/month_attendace_model.dart';
import 'package:ibn_khaldun/parent_module/data/models/semi_attendance_model.dart';
import 'package:ibn_khaldun/parent_module/data/parent_repository/parent_repository.dart';
import 'package:ibn_khaldun/parent_module/domain/base_parent_repository/base_parent_repository.dart';
import 'package:ibn_khaldun/parent_module/presentation/controllers/custom_calender_cubit/custom_calender_state.dart';

class CustomCalenderCubit extends Cubit<CustomCalendarState> {
  CustomCalenderCubit() : super(InitialCustomCalendarState());

  final BaseParentRepository _baseParentRepository = ParentRepository();
  late String id;
  late SemiAttendanceModel _semiAttendanceModel;
  late MonthAttendanceModel monthAttendanceModel;
  final Map<String, Color> sColor = const {
    'absent': Colors.red,
    'present': Color.fromRGBO(0, 102, 79, 1),
    'excused': Colors.blueGrey,
  };
  final List<Color> sColor2 = const [
    Colors.red,
    Color.fromRGBO(0, 102, 79, 1),
    Colors.blueGrey,
  ];
  final List<String> weekDays = const [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
  ];
  final List<String> days = const [
    'Day of absent',
    'Day of attendance',
    'Day of excuses',
  ];

  DateTime currentStart = DateTime.now();
  late DateTime semiStart;
  late DateTime semiEnd;
////////
  List<DateTime> calDays = [];
  List<DayStateModel> displayDays = [];
  /* List<DayStateModel> stateDays = [
    DayStateModel(DateTime(2023, 3, 16), 'absent'),
    DayStateModel(DateTime(2023, 3, 12), 'attend'),
    DayStateModel(DateTime(2023, 3, 20), 'execute'),
    DayStateModel(DateTime(2023, 3, 22), 'absent'),
    DayStateModel(DateTime(2023, 3, 27), 'attend'),
  ];*/
  DateTime getLastSundayInMonth(DateTime dateTime) {
    // Find the last day of the month
    DateTime lastDayOfMonth = DateTime(
      dateTime.year,
      dateTime.month,
      1,
    );

    // Subtract the number of days needed to get to the last Sunday
    if (lastDayOfMonth.weekday == 7) {
      return lastDayOfMonth;
    } else {
      return lastDayOfMonth.subtract(
        Duration(
          days: lastDayOfMonth.weekday,
        ),
      );
    }
  }

  void init(id) async {
    this.id = id;
    emit(InitialCustomCalendarState());
    await getStartAndEnd();
    semiStart = DateTime(
      int.parse(_semiAttendanceModel.startDate.split('/')[2]),
      int.parse(_semiAttendanceModel.startDate.split('/')[0]),
      int.parse(_semiAttendanceModel.startDate.split('/')[1]),
    );
    semiEnd = DateTime(
      int.parse(_semiAttendanceModel.endDate.split('/')[2]),
      int.parse(_semiAttendanceModel.endDate.split('/')[0]),
      int.parse(_semiAttendanceModel.endDate.split('/')[1]),
    );
    //print(_semiAttendanceModel.endDate);
    await getAttendMonthDay(
        int.parse(_semiAttendanceModel.startDate.split('/')[0]));
    calcNewWay(date: semiStart);
    checkStatus();
    //print(calDays);
    emit(GetDataSuccessfullyState());
  }

  Future<void> getStartAndEnd() async {
    _semiAttendanceModel =
        await _baseParentRepository.getStudentAttendanceSemester(id);
  }

  Future<void> getAttendMonthDay(int month) async {
    try {
      monthAttendanceModel =
          await _baseParentRepository.getStudentAttendanceMonth(id, month);
      // emit(GetDataSuccessfullyState());
    } on Exception catch (e) {
      emit(
        GetDataFailedState(
          e.toString(),
        ),
      );
    }
  }

  void calcNewWay({required DateTime date}) {
    calDays = [];
    currentStart = date;
    for (int i = 0; i < 42; i++) {
      calDays.add(
        date
            .copyWith(
              day: getLastSundayInMonth(date).day,
              month: getLastSundayInMonth(date).month,
            )
            .add(Duration(days: i)),
      );
    }
    //print(calDays);
    emit(ShowDetailCustomCalendarState());
  }

  void nextMonth() async {
    /*if (currentStart.isBefore(semiEnd.copyWith(day: 1).add(Duration(
            days: 30)) */ /*.subtract(
      const Duration(days: 30),
    )*/ /*
        )) */
    if (currentStart.year == semiEnd.year &&
        currentStart.month == semiEnd.month) {
      return;
    } else {
      emit(InitialCustomCalendarState());
      currentStart = currentStart.add(const Duration(days: 31));
      print('${currentStart.month}/${currentStart.day}');
      await getAttendMonthDay(currentStart.month);
      calcNewWay(date: currentStart);
      checkStatus();
      emit(NextCalendarState());
    }
  }

  void previousMonth() async {
    if (currentStart.year == semiStart.year &&
        currentStart.month == semiStart.month) {
      return;
    } else {
      emit(InitialCustomCalendarState());
      currentStart = currentStart.subtract(const Duration(days: 31));
      await getAttendMonthDay(currentStart.month);
      calcNewWay(date: currentStart);
      checkStatus();
      emit(PreviousCalendarState());
    }
  }

  void checkStatus() {
    displayDays = [];
    Map<String, String> stateDays = Map<String, String>.fromIterable(
      monthAttendanceModel.data ?? [],
      key: (item) => item.day,
      value: (item) => item.status,
    );
    for (var element in calDays) {
      String day = '${element.month}/${element.day}/${element.year}';
      String state = stateDays[day]?.toLowerCase() ?? '';
      displayDays.add(DayStateModel(element, state));
    }
    /* print(calDays);
    print(displayDays);*/
    emit(ShowDetailCustomCalendarState());
  }

  /*void checkStatus() {
    displayDays = [];
    bool flag = false;
    for (var element in calDays) {
      flag = false;
      for (var stateDay in stateDays) {
        if (element.year == stateDay.day.year &&
            element.month == stateDay.day.month &&
            element.day == stateDay.day.day) {
          print('object in');
          displayDays.add(stateDay);
          flag = true;
          break;
        }
      }
      if (!flag) {
        displayDays.add(
          DayStateModel(
            element,
            '',
          ),
        );
      }
    }
    emit(ShowDetailCustomCalendarState());
  }*/
}
