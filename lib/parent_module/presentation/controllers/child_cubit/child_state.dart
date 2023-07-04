part of 'child_cubit.dart';

@immutable
abstract class ChildState {}

class ChildInitialState extends ChildState {}

class LogsInitialState extends ChildState {}

class ChildReInitialState extends ChildState {}

//class GetStudentDataState extends ChildState {}

class GetStudentDataFailedState extends ChildState {
  GetStudentDataFailedState(this.message);

  final String message;
}

//class GetSemiAttendanceState extends ChildState {}
class LogsState extends ChildState {}

class GetDataSuccessfullyState extends ChildState {}

class GetSemiAttendanceFailedState extends ChildState {
  GetSemiAttendanceFailedState(this.message);

  final String message;
}
