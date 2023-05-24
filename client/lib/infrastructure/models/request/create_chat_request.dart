import 'dart:convert';

class CreateChatRequest {
  bool? isGroupChat;
  List<String>? membersId;

  CreateChatRequest({this.isGroupChat, this.membersId});

  CreateChatRequest.fromJson(Map<String, dynamic> json) {
    isGroupChat = json['isGroupChat'];
    membersId = json['membersId'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isGroupChat'] = isGroupChat;
    data['membersId'] = membersId;
    return data;
  }

  String prepareRequest() {
    return json.encode(toJson());
  }
}
