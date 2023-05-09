import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibn_khaldun/core/app_path.dart';
import 'package:ibn_khaldun/parent_module/data/models/card_style_model.dart';

part 'child_state.dart';

class ChildCubit extends Cubit<ChildState> {
  ChildCubit() : super(ChildInitialState());

  List<CardStyleModel> cards = [
    CardStyleModel(
      state: 'Day of attendance',
      backgroundColor: const Color.fromRGBO(255, 118, 72, 1),
      maskColor: const Color.fromRGBO(255, 194, 120, 1),
      icon: AppPath.success,
    ),
    CardStyleModel(
      state: 'Day of absent',
      backgroundColor: const Color.fromRGBO(143, 152, 255, 1),
      maskColor: const Color.fromRGBO(24, 42, 136, 1),
      icon: AppPath.subtract,
    ),
    CardStyleModel(
      state: 'Day of excuses',
      backgroundColor: const Color.fromRGBO(255, 194, 120, 1),
      maskColor: const Color.fromRGBO(255, 118, 72, 1),
      icon: AppPath.wrong,
    )
  ];
  CardStyleModel schedule = CardStyleModel(
    state: '5A \nSchedule',
    backgroundColor: const Color.fromRGBO(77, 197, 145, 1),
    maskColor: const Color.fromRGBO(0, 102, 79, 1),
    icon: AppPath.notes,
  );
}
