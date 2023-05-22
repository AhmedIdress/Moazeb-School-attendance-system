class LoginTeacherModel {
  late String token;
  late bool succeeded;
  late int status;
  late String message;
  String? errors;
  TeacherData? data;

  LoginTeacherModel(
      {required this.token,
      required this.succeeded,
      required this.status,
      required this.message,
      this.errors,
      this.data});

  LoginTeacherModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    succeeded = json['succeeded'];
    status = json['status'];
    message = json['message'];
    errors = json['errors'];
    data = json['data'] != null ? TeacherData.fromJson(json['data']) : null;
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

class TeacherData {
  late String id;
  late String email;
  late String name;
  late String governorate;
  late String city;
  late String specialize;
  String? phoneNumber;
  late String address;
  late String imageUrl;

  TeacherData(
      {required this.id,
      required this.email,
      required this.name,
      required this.governorate,
      required this.city,
      required this.specialize,
      this.phoneNumber,
      required this.address,
      required this.imageUrl});

  TeacherData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    name = json['name'];
    governorate = json['governorate'];
    city = json['city'];
    specialize = json['specialize'];
    phoneNumber = json['phoneNumber'];
    address = json['address'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['name'] = name;
    data['governorate'] = governorate;
    data['city'] = city;
    data['specialize'] = specialize;
    data['phoneNumber'] = phoneNumber;
    data['address'] = address;
    data['imageUrl'] = imageUrl;
    return data;
  }
}
