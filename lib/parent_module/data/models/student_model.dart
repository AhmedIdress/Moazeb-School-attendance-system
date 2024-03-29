class StudentModel {
  late bool succeeded;
  late int status;
  String? message;
  String? errors;
  StudentDataModel? data;

  StudentModel(
      {required this.succeeded,
      required this.status,
      this.message,
      this.errors,
      this.data});

  StudentModel.fromJson(Map<String, dynamic> json) {
    succeeded = json['succeeded'];
    status = json['status'];
    message = json['message'];
    errors = json['errors'];
    data =
        json['data'] != null ? StudentDataModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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

class StudentDataModel {
  late String id;
  late String name;
  late String gender;
  late int age;
  late String birthDate;
  late String grade;
  late String className;
  late String governorate;
  late String city;
  late String address;
  late String parentPhone;
  late String parentEmail;
  late String parentExternalEmail;
  late String parentNid;
  late String parentId;
  late String parentJob;
  String? imageUrl;

  StudentDataModel({
    required this.id,
    required this.name,
    required this.gender,
    required this.age,
    required this.birthDate,
    required this.grade,
    required this.className,
    required this.governorate,
    required this.city,
    required this.address,
    required this.parentPhone,
    required this.parentEmail,
    required this.parentExternalEmail,
    required this.parentNid,
    required this.parentId,
    required this.parentJob,
    this.imageUrl,
  });

  StudentDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    gender = json['gender'];
    age = json['age'];
    birthDate = json['birthDate'];
    grade = json['grade'];
    className = json['class'];
    governorate = json['governorate'];
    city = json['city'];
    address = json['address'];
    parentPhone = json['parentPhone'];
    parentEmail = json['parentEmail'];
    parentExternalEmail = json['parentExternalEmail'];
    parentNid = json['parentNid'];
    parentId = json['parentId'];
    parentJob = json['parentJob'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['gender'] = gender;
    data['age'] = age;
    data['birthDate'] = birthDate;
    data['grade'] = grade;
    data['class'] = className;
    data['governorate'] = governorate;
    data['city'] = city;
    data['address'] = address;
    data['parentPhone'] = parentPhone;
    data['parentEmail'] = parentEmail;
    data['parentExternalEmail'] = parentExternalEmail;
    data['parentNid'] = parentNid;
    data['parentId'] = parentId;
    data['parentJob'] = parentJob;
    data['imageUrl'] = imageUrl;
    return data;
  }
}
