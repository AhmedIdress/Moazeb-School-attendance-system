class LogModel {
  late String action;
  late String logTime;

  LogModel({required this.action, required this.logTime});

  LogModel.fromJson(Map<String, dynamic> json) {
    action = json['action'];
    logTime = json['logTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['action'] = action;
    data['logTime'] = logTime;
    return data;
  }
}
