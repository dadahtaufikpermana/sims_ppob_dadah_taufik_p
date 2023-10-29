import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  String? _jwtToken;

  String? get jwtToken => _jwtToken;

  // Konstruktor
  AuthService() {
    // Coba untuk mengambil token JWT dari SharedPreferences saat AuthService dibuat
    _loadToken();
  }

  // Fungsi untuk menyimpan token JWT
  Future<void> setJwtToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('jwtToken', token);
    _jwtToken = token;
    print("JWT Token set: $token"); // Tambahkan baris ini
  }

  // Fungsi untuk memuat token JWT
  Future<void> _loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    _jwtToken = prefs.getString('jwtToken');
  }

  // Fungsi untuk membersihkan token JWT
  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwtToken');
    _jwtToken = null;
  }
}
