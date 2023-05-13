class SemiAttendanceModel {
  late String startDate;
  late String endDate;
  late int total;
  late int present;
  late int absent;
  late int excused;
  late bool succeeded;
  late int status;
  String? message;
  String? errors;
  dynamic data;

  SemiAttendanceModel(
      {required this.startDate,
      required this.endDate,
      required this.total,
      required this.present,
      required this.absent,
      required this.excused,
      required this.succeeded,
      required this.status,
      this.message,
      this.errors,
      this.data});

  SemiAttendanceModel.fromJson(Map<String, dynamic> json) {
    startDate = json['startDate'];
    endDate = json['endDate'];
    total = json['total'];
    present = json['present'];
    absent = json['absent'];
    excused = json['excused'];
    succeeded = json['succeeded'];
    status = json['status'];
    message = json['message'];
    errors = json['errors'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['total'] = total;
    data['present'] = present;
    data['absent'] = absent;
    data['excused'] = excused;
    data['succeeded'] = succeeded;
    data['status'] = status;
    data['message'] = message;
    data['errors'] = errors;
    data['data'] = this.data;
    return data;
  }
}
