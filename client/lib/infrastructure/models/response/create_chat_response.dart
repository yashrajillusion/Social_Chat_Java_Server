import 'package:logger/logger.dart';

class CreateChatResponse {
  int? statusCode;
  String? message;
  Data? data;

  CreateChatResponse({this.statusCode, this.message, this.data});

  CreateChatResponse.fromJson(Map<String, dynamic> json) {
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

  static Future<CreateChatResponse?> parseInfo(Map<String, dynamic>? json) async {
    try {
      return CreateChatResponse.fromJson(json!);
    } catch (e) {
      Logger().e("get all users chat by id data parseInfo exception : $e");
      return null;
    }
  }
}

class Data {
  String? id;
  String? chatName;
  bool? isGroupChat;
  List<Members>? members;
  Null lastMessage;
  String? createdAt;

  Data({this.id, this.chatName, this.isGroupChat, this.members, this.lastMessage, this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    chatName = json['chatName'];
    isGroupChat = json['isGroupChat'];
    lastMessage = json['lastMessage'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['chatName'] = chatName;
    data['isGroupChat'] = isGroupChat;
    if (members != null) {
      data['members'] = members!.map((v) => v.toJson()).toList();
    }

    data['lastMessage'] = lastMessage;
    data['createdAt'] = createdAt;
    return data;
  }
}

class Members {
  String? id;
  String? firstName;
  String? lastName;
  String? phone;
  String? email;
  String? password;
  String? avatarUrl;
  String? createdAt;

  Members({this.id, this.firstName, this.lastName, this.phone, this.email, this.password, this.avatarUrl, this.createdAt});

  Members.fromJson(Map<String, dynamic> json) {
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
