class RegistrationModel {
  final int status;
  final String message;
  final dynamic data;

  RegistrationModel({required this.status, required this.message, this.data});

  factory RegistrationModel.fromJson(Map<String, dynamic> json) {
    return RegistrationModel(
      status: json['status'],
      message: json['message'],
      data: json['data'],
    );
  }
}
