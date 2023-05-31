class TeacherTableModel {
  late bool succeeded;
  late int status;
  String? message;
  String? errors;
  List<TeacherTable>? data;

  TeacherTableModel(
      {required this.succeeded,
      required this.status,
      this.message,
      this.errors,
      this.data});

  TeacherTableModel.fromJson(Map<String, dynamic> json) {
    succeeded = json['succeeded'];
    status = json['status'];
    message = json['message'];
    errors = json['errors'];
    if (json['data'] != null) {
      data = <TeacherTable>[];
      json['data'].forEach((v) {
        data!.add(TeacherTable.fromJson(v));
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
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TeacherTable {
  late String day;
  late int periodNo;
  late String period;
  late String subjectCode;
  late String subjectName;

  TeacherTable(
      {required this.day,
      required this.periodNo,
      required this.period,
      required this.subjectCode,
      required this.subjectName});

  TeacherTable.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    periodNo = json['periodNo'];
    period = json['period'];
    subjectCode = json['subjectCode'];
    subjectName = json['subjectName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['day'] = day;
    data['periodNo'] = periodNo;
    data['period'] = period;
    data['subjectCode'] = subjectCode;
    data['subjectName'] = subjectName;
    return data;
  }
}
