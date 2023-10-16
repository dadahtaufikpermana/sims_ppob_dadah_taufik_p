class ProfileModel {
  final int status;
  final String message;
  final ProfileData data;

  ProfileModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      status: json['status'],
      message: json['message'],
      data: ProfileData.fromJson(json['data']),
    );
  }
}

class ProfileData {
  final String email;
  final String firstName;
  final String lastName;
  final String profileImage;

  ProfileData({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.profileImage,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) {
    return ProfileData(
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      profileImage: json['profile_image'],
    );
  }
}
