part of 'study_schedule_cubit.dart';

@immutable
abstract class StudyScheduleState {}

class StudyScheduleInitialState extends StudyScheduleState {}

class StudyScheduleChangeDayState extends StudyScheduleState {}

class GetDataStudyScheduleState extends StudyScheduleState {}

class TransDataStudyScheduleState extends StudyScheduleState {}
