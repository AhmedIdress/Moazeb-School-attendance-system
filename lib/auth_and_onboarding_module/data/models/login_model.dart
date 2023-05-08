class LoginModel {
  late String token;
  late bool succeeded;
  late int status;
  late String message;
  String? errors;
  LoginData? data;

  LoginModel(
      {required this.token,
      required this.succeeded,
      required this.status,
      required this.message,
      this.errors,
      this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    succeeded = json['succeeded'];
    status = json['status'];
    message = json['message'];
    errors = json['errors'];
    data = json['data'] != null ? LoginData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    data['succeeded'] = succeeded;
    data['status'] = status;
    data['message'] = message;
    data['errors'] = errors;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class LoginData {
  late String parentId;
  late String parentName;
  late String email;
  late String nid;
  late String governorate;
  late String city;
  late String address;
  late String job;
  late String externalEmail;
  late String phoneNumber;
  List<ParentStudents>? students;

  LoginData(
      {required this.parentId,
      required this.parentName,
      required this.email,
      required this.nid,
      required this.governorate,
      required this.city,
      required this.address,
      required this.job,
      required this.externalEmail,
      required this.phoneNumber,
      this.students});

  LoginData.fromJson(Map<String, dynamic> json) {
    parentId = json['parentId'];
    parentName = json['parentName'];
    email = json['email'];
    nid = json['nid'];
    governorate = json['governorate'];
    city = json['city'];
    address = json['address'];
    job = json['job'];
    externalEmail = json['externalEmail'];
    phoneNumber = json['phoneNumber'];
    if (json['students'] != null) {
      students = <ParentStudents>[];
      json['students'].forEach((v) {
        students!.add(ParentStudents.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['parentId'] = parentId;
    data['parentName'] = parentName;
    data['email'] = email;
    data['nid'] = nid;
    data['governorate'] = governorate;
    data['city'] = city;
    data['address'] = address;
    data['job'] = job;
    data['externalEmail'] = externalEmail;
    data['phoneNumber'] = phoneNumber;
    if (students != null) {
      data['students'] = students!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ParentStudents {
  late String name;
  late String studentId;

  ParentStudents({
    required this.name,
    required this.studentId,
  });

  ParentStudents.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    studentId = json['studentId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['studentId'] = studentId;
    return data;
  }
}
