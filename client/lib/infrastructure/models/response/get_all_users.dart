import 'package:logger/logger.dart';

class GetAllUsers {
  int? statusCode;
  String? message;
  List<GetAllUsersDataList>? data;

  GetAllUsers({this.statusCode, this.message, this.data});

  GetAllUsers.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <GetAllUsersDataList>[];
      json['data'].forEach((v) {
        data!.add(GetAllUsersDataList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  static Future<GetAllUsers?> parseInfo(Map<String, dynamic>? json) async {
    try {
      return GetAllUsers.fromJson(json!);
    } catch (e) {
      Logger().e("get all users data parseInfo exception : $e");
      return null;
    }
  }
}

class GetAllUsersDataList {
  String? id;
  String? firstName;
  String? lastName;
  String? phone;
  String? email;
  String? password;
  String? avatarUrl;
  String? createdAt;

  GetAllUsersDataList(
      {this.id, this.firstName, this.lastName, this.phone, this.email, this.password, this.avatarUrl, this.createdAt});

  GetAllUsersDataList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    phone = json['phone'];
    email = json['email'];
    password = json['password'];
    avatarUrl = json['avatarUrl'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['phone'] = phone;
    data['email'] = email;
    data['password'] = password;
    data['avatarUrl'] = avatarUrl;
    data['createdAt'] = createdAt;
    return data;
  }
}
