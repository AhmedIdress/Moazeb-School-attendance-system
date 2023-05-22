class PeriodTimeModel {
  late bool succeeded;
  late int status;
  String? message;
  String? errors;
  Map<int, Period>? period = {};

  PeriodTimeModel(
      {required this.succeeded,
      required this.status,
      this.message,
      this.errors,
      this.period});

  PeriodTimeModel.fromJson(Map<String, dynamic> json) {
    succeeded = json['succeeded'];
    status = json['status'];
    message = json['message'];
    errors = json['errors'];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        var model = Period.fromJson(v);
        period?[model.index] = model;
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['succeeded'] = succeeded;
    data['status'] = status;
    data['message'] = message;
    data['errors'] = errors;
    if (period != null) {
      data['data'] = period?.values.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Period {
  late int index;
  late String name;
  late String startTime;
  late String endTime;

  Period(
      {required this.index,
      required this.name,
      required this.startTime,
      required this.endTime});

  Period.fromJson(Map<String, dynamic> json) {
    index = json['index'];
    name = json['name'];
    startTime = json['startTime'];
    endTime = json['endTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['index'] = index;
    data['name'] = name;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    return data;
  }
}
