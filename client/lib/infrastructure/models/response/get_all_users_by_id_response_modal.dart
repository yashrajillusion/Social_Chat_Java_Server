import 'package:logger/logger.dart';

class GetUsersByIdResponseModal {
  int? statusCode;
  String? message;
  List<GetUsersByIdData>? data;

  GetUsersByIdResponseModal({this.statusCode, this.message, this.data});

  GetUsersByIdResponseModal.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <GetUsersByIdData>[];
      json['data'].forEach((v) {
        data!.add(GetUsersByIdData.fromJson(v));
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

  static Future<GetUsersByIdResponseModal?> parseInfo(Map<String, dynamic>? json) async {
    try {
      return GetUsersByIdResponseModal.fromJson(json!);
    } catch (e) {
      Logger().e("get all users by id data parseInfo exception : $e");
      return null;
    }
  }
}

class GetUsersByIdData {
  String? id;
  String? chatName;
  bool? isGroupChat;
  List<MembersOfChats>? members;
  LastMessage? lastMessage;
  String? createdAt;

  GetUsersByIdData({this.id, this.chatName, this.isGroupChat, this.members, this.lastMessage, this.createdAt});

  GetUsersByIdData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    chatName = json['chatName'];
    isGroupChat = json['isGroupChat'];
    if (json['members'] != null) {
      members = <MembersOfChats>[];
      json['members'].forEach((v) {
        members!.add(MembersOfChats.fromJson(v));
      });
    }

    lastMessage = json['lastMessage'] != null ? LastMessage.fromJson(json['lastMessage']) : null;
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
    if (lastMessage != null) {
      data['lastMessage'] = lastMessage!.toJson();
    }
    data['createdAt'] = createdAt;
    return data;
  }
}

class MembersOfChats {
  String? id;
  String? firstName;
  String? lastName;
  String? phone;
  String? email;
  String? password;
  String? avatarUrl;
  String? createdAt;

  MembersOfChats({this.id, this.firstName, this.lastName, this.phone, this.email, this.password, this.avatarUrl, this.createdAt});

  MembersOfChats.fromJson(Map<String, dynamic> json) {
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

class LastMessage {
  String? id;
  MembersOfChats? sender;
  Null? senderId;
  Null? chatId;
  String? message;
  String? createdAt;

  LastMessage({this.id, this.sender, this.senderId, this.chatId, this.message, this.createdAt});

  LastMessage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sender = json['sender'] != null ? MembersOfChats.fromJson(json['sender']) : null;
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
