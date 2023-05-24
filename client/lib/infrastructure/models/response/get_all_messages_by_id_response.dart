import 'package:logger/logger.dart';

class GetAllMessagesByIdResponse {
  int? statusCode;
  String? message;
  List<GetAllMessagesByIdData>? data;

  GetAllMessagesByIdResponse({this.statusCode, this.message, this.data});

  GetAllMessagesByIdResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <GetAllMessagesByIdData>[];
      json['data'].forEach((v) {
        data!.add(GetAllMessagesByIdData.fromJson(v));
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

  static Future<GetAllMessagesByIdResponse?> parseInfo(Map<String, dynamic>? json) async {
    try {
      return GetAllMessagesByIdResponse.fromJson(json!);
    } catch (e) {
      Logger().e("get all users chat by id data parseInfo exception : $e");
      return null;
    }
  }
}

class GetAllMessagesByIdData {
  String? id;
  Sender? sender;
  String? senderId;
  String? chatId;
  String? message;
  String? createdAt;

  GetAllMessagesByIdData({this.id, this.sender, this.senderId, this.chatId, this.message, this.createdAt});

  GetAllMessagesByIdData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sender = json['sender'] != null ? Sender.fromJson(json['sender']) : null;
    senderId = json['senderId'];
    chatId = json['chatId'];
    message = json['message'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (sender != null) {
      data['sender'] = sender!.toJson();
    }
    data['senderId'] = senderId;
    data['chatId'] = chatId;
    data['message'] = message;
    data['createdAt'] = createdAt;
    return data;
  }
}

class Sender {
  String? id;
  String? firstName;
  String? lastName;
  String? phone;
  String? email;
  String? password;
  String? avatarUrl;
  String? createdAt;

  Sender({this.id, this.firstName, this.lastName, this.phone, this.email, this.password, this.avatarUrl, this.createdAt});

  Sender.fromJson(Map<String, dynamic> json) {
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
