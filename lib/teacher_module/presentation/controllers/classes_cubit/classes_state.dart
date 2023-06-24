part of 'classes_cubit.dart';

@immutable
abstract class ClassesState {}

class ClassesInitialState extends ClassesState {}

class ClassesGetSuccessfullyState extends ClassesState {}

class ClassesRefreshState extends ClassesState {}

class ClassesGetFailedState extends ClassesState {
  ClassesGetFailedState(this.message);

  final String message;
}
