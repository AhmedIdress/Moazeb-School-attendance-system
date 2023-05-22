String baseUrl = /*'https://localhost:5001/api/'*/
    'http://payrolly-001-site1.ftempurl.com/api/';
String imageHost = 'http://payrolly-001-site1.ftempurl.com/api';
const List<String> weekDays = [
  'Sunday',
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Saturday',
];
const List<String> workDays = [
  'Sunday',
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
];

class AppEndPoint {
  static String login = 'login';
  static String attendSemester = 'attendance/students/semester/';
  static String attendMonth = 'attendance/students/month';
  static String getStudent = 'students/';
  static String getTimes = 'Timetable/classes-times';
  static String getStudentSchedule = 'timetable/class/';
}

class AppLocalDataKeys {
  static String token = 'token';
  static String tokenTeacher = 'tokenTeacher';
  static String parent = 'parent';
  static String teacher = 'teacher';
  static String cacheBoxName = 'cacheData';
  static String dark = 'dark';
  static String arabic = 'arabic';
  static String first = 'first';
}
