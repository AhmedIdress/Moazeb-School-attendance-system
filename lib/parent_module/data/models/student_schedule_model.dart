import 'package:ibn_khaldun/core/constants.dart';

class StudentScheduleModel {
  late bool succeeded;
  late int status;
  String? message;
  String? errors;
  //Map<String, Day>? data = {};
  Map<String, Map<String, dynamic>>? data = {};

  StudentScheduleModel({
    required this.succeeded,
    required this.status,
    this.message,
    this.errors,
    this.data,
  });

  StudentScheduleModel.fromJson(Map<String, dynamic> json) {
    succeeded = json['succeeded'];
    status = json['status'];
    message = json['message'];
    errors = json['errors'];
    // json['data'] != null ? data = json['data'] : null;

    //List<String> keys = json['data'].keys;
    /*workDays.forEach((element) {
      data?[element.toLowerCase()] =
          Day.fromJson(json['data'][element.toLowerCase()]);
    });*/
    if (json['data'] != null) {
      workDays.forEach((element) {
        data?[element.toLowerCase()] = json['data'][element.toLowerCase()];
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['succeeded'] = succeeded;
    data['status'] = status;
    data['message'] = message;
    data['errors'] = errors;
    if (this.data != null) {
      data['data'] = this.data;
    }
    return data;
  }
}

/*
class Day {
  late String first;
  late String second;
  late String third;
  late String forth;
  late String fifth;
  late String sixth;
  late String seventh;
  late Map<String, dynamic> map;
  Day(
      {required this.first,
      required this.second,
      required this.third,
      required this.forth,
      required this.fifth,
      required this.sixth,
      required this.seventh});

  Day.fromJson(Map<String, dynamic> json) {
    map = json;
    first = json['first'];
    second = json['second'];
    third = json['third'];
    forth = json['forth'];
    fifth = json['fifth'];
    sixth = json['sixth'];
    seventh = json['seventh'];
  }

  String getNumber(String number) {
    return map[number];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first'] = first;
    data['second'] = second;
    data['third'] = third;
    data['forth'] = forth;
    data['fifth'] = fifth;
    data['sixth'] = sixth;
    data['seventh'] = seventh;
    return data;
  }
}
*/
