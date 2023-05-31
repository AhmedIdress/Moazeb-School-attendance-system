part of 'teacher_cubit.dart';

@immutable
abstract class TeacherState {}

class TeacherInitialState extends TeacherState {}

class GetTeacherTableState extends TeacherState {}

class TeacherTableDayState extends TeacherState {}

class TransTeacherScheduleState extends TeacherState {}
