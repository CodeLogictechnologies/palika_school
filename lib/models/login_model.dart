class LoginModel {
  final int userid;
  final int palikaprofileid;
  final String token;
  LoginModel(
      {required this.userid,
      required this.palikaprofileid,
      required this.token});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
        userid: json['userid'],
        palikaprofileid: json['palikaprofileid'],
        token: json['token']);
  }

  Map<String, dynamic> toJson() {
    return {
      'userid': userid,
      'palikaprofileid': palikaprofileid,
      'token': token
    };
  }
}

class LoginResponseModel {
  final String type;
  final String message;
  final LoginModel? response;
  LoginResponseModel(
      {required this.type, required this.message, this.response});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
        type: json['type'],
        message: json['message'],
        response: json['response'] != null
            ? LoginModel.fromJson(json['response'])
            : null);
  }

  Map<String, dynamic> toJson() {
    return {'type': type, 'message': message, 'response': response?.toJson()};
  }
}

class LogoutResponseModel {
  final String type;
  final String message;
  final bool? response;
  LogoutResponseModel(
      {required this.type, required this.message, required this.response});

  factory LogoutResponseModel.fromJson(Map<String, dynamic> json) {
    return LogoutResponseModel(
        type: json['type'],
        message: json['message'],
        response: json['response']);
  }
}
