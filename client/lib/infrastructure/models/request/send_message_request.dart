import 'dart:convert';

class SendMessageRequest {
  String? senderId;
  String? chatId;
  String? message;

  SendMessageRequest({this.senderId, this.chatId, this.message});

  SendMessageRequest.fromJson(Map<String, dynamic> json) {
    senderId = json['senderId'];
    chatId = json['chatId'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['senderId'] = senderId;
    data['chatId'] = chatId;
    data['message'] = message;
    return data;
  }

  String prepareRequest() {
    return json.encode(toJson());
  }
}
