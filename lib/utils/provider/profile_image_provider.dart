import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:sims_ppob_dadah_taufik_p/utils/provider/prefference_setting_provider.dart';
import 'package:flutter/material.dart';

import '../../data/models/profile_model.dart';

class ProfileImageProvider extends ChangeNotifier {
  final PreferenceSettingsProvider preferenceSettingsProvider;
  final BuildContext context;

  ProfileImageProvider(this.preferenceSettingsProvider, this.context);

  String? _imagePath;
  String? _imageUrl;

  String? get imagePath => _imagePath;
  String? get imageUrl => _imageUrl;

  void setImagePath(String path) {
    _imagePath = path;
    notifyListeners();
  }

  Future<void> updateProfileImage(String imagePath) async {
    final preferenceSettingsProvider = Provider.of<PreferenceSettingsProvider>(context, listen: false);
    final jwtToken = preferenceSettingsProvider.jwtToken;
    print('JWT Token di updateProfileImage: $jwtToken');

    if (jwtToken == null) {
      throw Exception('Token JWT tidak tersedia. Harap login terlebih dahulu.');
    }
    const String baseUrl = "https://take-home-test-api.nutech-integrasi.app";
    final url = '$baseUrl/profile/image';

    final imageFile = File(imagePath);
    print('Image Path yang Dikirim ke Server: $imagePath');

    if (!imageFile.existsSync()) {
      throw Exception('File gambar tidak ditemukan.');
    }

    try {
      // Buat permintaan multipart PUT
      final request = http.MultipartRequest('PUT', Uri.parse(url));

      // Atur header Authorization
      request.headers['Authorization'] = 'Bearer $jwtToken';

      // Tambahkan file gambar ke dalam requesst
      request.files.add(http.MultipartFile(
        'file',
        imageFile.readAsBytes().asStream(),
        imageFile.lengthSync(),
        filename: 'file', // Nama file yang sesuai
        contentType: MediaType('image', 'jpg'), // Sesuaikan dengan jenis gambar yang diunggah
      ));

      // Kirim permintaan
      final response = await http.Response.fromStream(await request.send());

      // Periksa respons
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print('Respons dari Server: ${response.body}');
        final profileModel = ProfileModel.fromJson(responseData);

        if (profileModel.status == 0) {
          // Gambar profil berhasil diubah
          final updatedProfileImage = profileModel.data.profileImage;

          // menampilkannya di UI
          _imageUrl = updatedProfileImage;
          notifyListeners();
        } else {
          print('Gagal mengedit profil gambar: ${profileModel.message}');
        }
      } else {
        print('Gagal mengirim permintaan PUT: ${response.statusCode}');
      }
    } catch (error) {
      print('Gagal mengirim permintaan PUT: $error');
    }
  }



}
