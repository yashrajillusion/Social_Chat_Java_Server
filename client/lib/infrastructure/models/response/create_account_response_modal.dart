import 'package:logger/logger.dart';

class CreateAccountResponsemodal {
  String? firstName;
  String? lastName;
  String? phone;
  String? email;
  String? password;

  CreateAccountResponsemodal({this.firstName, this.lastName, this.phone, this.email, this.password});

  CreateAccountResponsemodal.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    phone = json['phone'];
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['phone'] = phone;
    data['email'] = email;
    data['password'] = password;
    return data;
  }

  static Future<CreateAccountResponsemodal?> parseInfo(Map<String, dynamic>? json) async {
    try {
      return CreateAccountResponsemodal.fromJson(json!);
    } catch (e) {
      Logger().e("get coins data parseInfo exception : $e");
      return null;
    }
  }
}
