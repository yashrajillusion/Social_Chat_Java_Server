import 'package:logger/logger.dart';

class CreateAccountResponsemodal {
  int? statusCode;
  String? message;
  Data? data;

  CreateAccountResponsemodal({this.statusCode, this.message, this.data});

  CreateAccountResponsemodal.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }

  static Future<CreateAccountResponsemodal?> parseInfo(Map<String, dynamic>? json) async {
    try {
      return CreateAccountResponsemodal.fromJson(json!);
    } catch (e) {
      Logger().e("create account data parseInfo exception : $e");
      return null;
    }
  }
}

class Data {
  String? id;
  String? firstName;
  String? lastName;
  String? phone;
  String? email;
  String? password;
  String? avatarUrl;
  String? createdAt;

  Data({this.id, this.firstName, this.lastName, this.phone, this.email, this.password, this.avatarUrl, this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
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
