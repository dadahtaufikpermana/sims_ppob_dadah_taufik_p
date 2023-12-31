import 'package:flutter/material.dart';

class PreferenceSettingsProvider extends ChangeNotifier {
  String? firstName;
  String? email;
  String? lastName;
  String? profileImage;
  String? jwtToken;
  int? balance;

  //  method untuk mengupdate JWT token
  void setJwtToken(String token) {
    jwtToken = token;
    notifyListeners();
    print("JWT Token set in PreferenceSettingsProvider: $token");
  }

  //  method untuk mengupdate nama depan
  void setFirstName(String name) {
    firstName = name;
    notifyListeners();
  }

  //  method untuk mengupdate nama belakang
  void setLastName(String name) {
    lastName = name;
    notifyListeners();
  }


  void setEmail(String name) {
    email = name;
    notifyListeners();
  }

  //  method untuk mengupdate gambar profil
  void setProfileImage(String imageUrl) {
    profileImage = imageUrl;
    notifyListeners();
  }

  //  method untuk mengupdate saldo
  void setBalance(int newBalance) {
    balance = newBalance;
    notifyListeners();
  }
}
