import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibn_khaldun/parent_module/data/models/day_state_model.dart';
import 'package:ibn_khaldun/parent_module/presentation/controllers/custom_calender_cubit/custom_calender_state.dart';

class CustomCalenderCubit extends Cubit<CustomCalendarState> {
  CustomCalenderCubit() : super(InitialCustomCalendarState()) {
    calcNewWay(
      date: today,
    );
  }
  DateTime today = DateTime.now();
  DateTime currentStart = DateTime.now();
  DateTime semiStart = DateTime.utc(2023, 2, 1);
  DateTime semiEnd = DateTime.utc(2023, 5, 30);
  List<DateTime> calDays = [];
  List<DayStateModel> displayDays = [];
  List<DayStateModel> stateDays = [
    DayStateModel(DateTime(2023, 3, 16), 'absent'),
    DayStateModel(DateTime(2023, 3, 12), 'attend'),
    DayStateModel(DateTime(2023, 3, 20), 'execute'),
    DayStateModel(DateTime(2023, 3, 22), 'absent'),
    DayStateModel(DateTime(2023, 3, 27), 'attend'),
  ];
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
    checkStatus();
    emit(ShowDetailCustomCalendarState());
  }

  void nextMonth() {
    if (currentStart.isBefore(semiEnd.subtract(
      const Duration(days: 30),
    ))) {
      calcNewWay(date: currentStart.add(const Duration(days: 30)));
    }
    emit(ShowDetailCustomCalendarState());
  }

  void previousMonth() {
    if (currentStart.isAfter(semiStart.add(const Duration(days: 30)))) {
      calcNewWay(date: currentStart.subtract(const Duration(days: 30)));
    }
    emit(ShowDetailCustomCalendarState());
  }

  void checkStatus() {
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
  }
}
