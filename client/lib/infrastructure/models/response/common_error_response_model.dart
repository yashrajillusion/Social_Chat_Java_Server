class CommonErrorResponseModel {
  int? statusCode;
  String? error;
  String? message;

  CommonErrorResponseModel({this.statusCode, this.error, this.message});

  CommonErrorResponseModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    error = json['error'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['error'] = error;
    data['message'] = message;
    return data;
  }
}
