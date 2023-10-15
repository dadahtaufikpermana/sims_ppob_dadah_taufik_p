import 'dart:convert';
import 'package:http/http.dart' as http;

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

    final response = await http.post(Uri.parse(url),
        body: json.encode(data),
        headers: {
          'Content-Type': 'application/json',
        });

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      return responseData;
    } else {
      throw Exception('Paramter email tidak sesuai format');
    }
  }
}
