import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/balance_model.dart';
import '../models/banner_model.dart';
import '../models/profile_model.dart';
import '../models/service_model.dart';
import '../models/topup_model.dart';

class ApiService {
  final String baseUrl = "https://take-home-test-api.nutech-integrasi.app";

  Future registerUser({
    required String email,
    required String firstName,
    required String lastName,
    required String password,
  }) async {
    final url = '$baseUrl/registration';

    final Map<String, dynamic> data = {
      "email": email,
      "first_name": firstName,
      "last_name": lastName,
      "password": password,
    };

    final response =
        await http.post(Uri.parse(url), body: json.encode(data), headers: {
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      return responseData;
    } else {
      throw Exception('Paramter email tidak sesuai format');
    }
  }

  Future loginUser({
    required String email,
    required String password,
  }) async {
    final url = '$baseUrl/login';

    final Map<String, dynamic> data = {
      "email": email,
      "password": password,
    };

    final response = await http.post(
      Uri.parse(url),
      body: json.encode(data),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      final jwtToken = responseData['data']['token'];
      return jwtToken;
    } else if (response.statusCode == 400) {
      final responseData = json.decode(response.body);
      throw Exception(responseData['message']);
    } else if (response.statusCode == 401) {
      final responseData = json.decode(response.body);
      throw Exception(responseData['message']);
    }
  }

  Future<ProfileModel> getProfile(String jwtToken) async {
    final url = '$baseUrl/profile';

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $jwtToken',
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      final data = responseData['data'];

      return ProfileModel(
        status: responseData['status'],
        message: responseData['message'],
        data: ProfileData.fromJson(data),
      );
    } else {
      throw Exception('Gagal mengambil data profil');
    }
  }

  Future<BalanceModel> getBalance(String jwtToken) async {
    final url = '$baseUrl/balance';

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $jwtToken',
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      final balanceModel = BalanceModel.fromJson(responseData);
      return balanceModel;
    } else {
      throw Exception('Gagal mengambil saldo');
    }
  }

  Future<List<ServiceModel>> getServices(String jwtToken) async {
    final url = '$baseUrl/services';

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $jwtToken',
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      final serviceList = responseData['data'] as List<dynamic>;

      List<ServiceModel> services = serviceList.map((serviceData) {
        return ServiceModel(
          serviceCode: serviceData['service_code'],
          serviceName: serviceData['service_name'],
          serviceIcon: serviceData['service_icon'],
          serviceTariff: serviceData['service_tariff'],
        );
      }).toList();

      return services;
    } else {
      throw Exception('Gagal mengambil data layanan');
    }
  }

  Future<List<BannerModel>> getBanners(String jwtToken) async {
    final url = '$baseUrl/banner';

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $jwtToken',
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      final bannerList = responseData['data'] as List<dynamic>;

      List<BannerModel> banners = bannerList.map((bannerData) {
        return BannerModel(
          bannerImage: bannerData['banner_image'],
        );
      }).toList();

      return banners;
    } else {
      throw Exception('Gagal mengambil data banner');
    }
  }

  Future<TopUpModel> doTopUp(String jwtToken, double topUpAmount) async {
    if (topUpAmount < 10000 || topUpAmount > 1000000) {
      throw Exception('Nominal top up harus antara 10.000 dan 1.000.000');
    }

    final url = '$baseUrl/topup';

    final Map<String, dynamic> data = {
      "top_up_amount": topUpAmount,
    };

    final response = await http.post(
      Uri.parse(url),
      body: json.encode(data),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwtToken',
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      return TopUpModel.fromJson(responseData);
    } else {
      throw Exception('Gagal melakukan top up');
    }
  }


}
