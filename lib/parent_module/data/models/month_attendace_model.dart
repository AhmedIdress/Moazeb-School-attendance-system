class MonthAttendanceModel {
  late int total;
  late int present;
  late int absent;
  late int excused;
  late bool succeeded;
  late int status;
  String? message;
  String? errors;
  List<AttendDayData>? data;

  MonthAttendanceModel(
      {required this.total,
      required this.present,
      required this.absent,
      required this.excused,
      required this.succeeded,
      required this.status,
      this.message,
      this.errors,
      this.data});

  MonthAttendanceModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    present = json['present'];
    absent = json['absent'];
    excused = json['excused'];
    succeeded = json['succeeded'];
    status = json['status'];
    message = json['message'];
    errors = json['errors'];
    if (json['data'] != null) {
      data = <AttendDayData>[];
      json['data'].forEach((v) {
        data!.add(AttendDayData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['present'] = present;
    data['absent'] = absent;
    data['excused'] = excused;
    data['succeeded'] = succeeded;
    data['status'] = status;
    data['message'] = message;
    data['errors'] = errors;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AttendDayData {
  late String day;
  late String status;
  int? numberOfLogs;

  AttendDayData({required this.day, required this.status, this.numberOfLogs});

  AttendDayData.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    status = json['status'];
    numberOfLogs = json['numberOfLogs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['day'] = day;
    data['status'] = status;
    data['numberOfLogs'] = numberOfLogs;
    return data;
  }
}
