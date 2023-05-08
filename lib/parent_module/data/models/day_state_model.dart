class DayStateModel{
  late DateTime day;
  late String state;

  DayStateModel.fromJson(Map<String,dynamic> map){
    day = map['day'];
    state = map['state'];
  }

  DayStateModel(this.day, this.state);
}