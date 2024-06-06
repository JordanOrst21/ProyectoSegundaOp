import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String _baseUrl = 'http://localhost:8898';

  Future<bool> login(String email, String password) async {
    print("Entra en login de Service $email $password");
    final response = await http.post(
      Uri.parse('$_baseUrl/login'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({'email': email, 'password': password}),
    );
    print('response.body');
    print(response.body);
    print('response. desíes');

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to login');
    }
  }
}
