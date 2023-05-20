import 'dart:convert';

class LoginAccountRequestModal {
  String? email;
  String? password;

  LoginAccountRequestModal({this.email, this.password});

  LoginAccountRequestModal.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    return data;
  }

  String prepareRequest() {
    return json.encode(toJson());
  }
}
