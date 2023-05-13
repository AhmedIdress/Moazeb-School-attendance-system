abstract class CustomCalendarState {}

class InitialCustomCalendarState extends CustomCalendarState {}

class ShowDetailCustomCalendarState extends CustomCalendarState {}

class GetDataSuccessfullyState extends CustomCalendarState {}

class NextCalendarState extends CustomCalendarState {}

class PreviousCalendarState extends CustomCalendarState {}

class GetDataFailedState extends CustomCalendarState {
  GetDataFailedState(this.message);
  final String message;
}
