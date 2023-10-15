class LoginModel {
  final int status;
  final String message;
  final LoginData data;

  LoginModel({required this.status, required this.message, required this.data});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      status: json['status'] as int,
      message: json['message'] as String,
      data: LoginData.fromJson(json['data']),
    );
  }
}

class LoginData {
  final String token;

  LoginData({required this.token});

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      token: json['token'] as String,
    );
  }
}
