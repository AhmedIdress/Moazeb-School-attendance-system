import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:ibn_khaldun/auth_and_onboarding_module/data/models/login_model.dart';
import 'package:ibn_khaldun/parent_module/data/parent_repository/parent_repository.dart';
import 'package:ibn_khaldun/parent_module/domain/base_parent_repository/base_parent_repository.dart';

part 'children_state.dart';

class ChildrenCubit extends Cubit<ChildrenState> {
  ChildrenCubit() : super(ChildrenInitialState()) {
    getLoginData();
  }
  final BaseParentRepository _baseParentRepository = ParentRepository();
  late LoginData loginData;
  void getLoginData() async {
    loginData = await _baseParentRepository.getParentLoinData();
    /*loginData = LoginData.fromJson({
      "parentId": "d5ab7448-ae16-4987-876f-d9ed14a0c90a",
      "parentName": "Ibrahim Idress",
      "email": "ibrahimidress@parent.ibnkhaldun",
      "nid": "1234",
      "governorate": "menofia",
      "city": "menouf city",
      "address": "sansaft",
      "job": "software engineer",
      "externalEmail": "parent@gmail.com",
      "phoneNumber": "012",
      "imageUrl": "/Images/default.png",
      "students": [
        {"name": "Ahmed", "studentId": "445bc545-7bda-4adb-858a-05ccf0119a5b"},
        {"name": "omar", "studentId": "64c40472-9209-49be-b7f4-1efbe24e0993"},
        {"name": "Mohamed", "studentId": "cd5b87c4-cb53-41d0-a0f8-2f25b1de5cd7"}
      ]
    });
    */
    emit(GetLoginDataSuccessfullyState());
  }
}
