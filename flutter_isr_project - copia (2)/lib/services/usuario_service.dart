import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_isr_project/models/usuario.dart';

class UsuarioService {
  final String _baseUrl = "http://localhost:8898";

  // Future<bool> login(String correo, String password) async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse('$_baseUrl/usuario/login'),
  //       headers: {'Content-Type': 'application/json'},
  //       body: jsonEncode({'correo': correo, 'password': password}),
  //     );

  //     print('Response status: ${response.statusCode}');
  //     print('Response body: ${response.body}');

  //     if (response.statusCode == 200) {
  //       final jsonResponse = jsonDecode(response.body);
  //       final authenticated = jsonResponse['authenticated'] as bool;
  //       return authenticated;
  //     } else {
  //       print('Error en login: ${response.body}');
  //       throw Exception('Fallo al validar los datos: ${response.reasonPhrase}');
  //     }
  //   } catch (e) {
  //     print('Error en login: $e');
  //     throw Exception('Fallo al cargar el usuario: $e');
  //   }
  // }

  Future<Usuario> crearUsuario(
      String nombre, String correo, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(
            {'nombre': nombre, 'correo': correo, 'password': password}),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        return Usuario.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 409) {
        print('Usuario ya existe: ${response.body}');
        throw Exception('El usuario ya existe');
      } else {
        print('Error en crearUsuario: ${response.body}');
        throw Exception('Fallo al crear usuario: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error en crearUsuario: $e');
      throw Exception('Fallo al crear el usuario: $e');
    }
  }

  Future<Usuario> actualizarUsuario(
      int id, String nombre, String correo, String password) async {
    try {
      final response = await http.put(
        Uri.parse('$_baseUrl/usuario/$id'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(
            {'nombre': nombre, 'correo': correo, 'password': password}),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        return Usuario.fromJson(jsonDecode(response.body));
      } else {
        print('Error en actualizarUsuario: ${response.body}');
        throw Exception(
            'Fallo al actualizar usuario: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error en actualizarUsuario: $e');
      throw Exception('Fallo al actualizar el usuario: $e');
    }
  }

  Future<void> eliminarUsuario(int id) async {
    try {
      final response = await http.delete(Uri.parse('$_baseUrl/usuario/$id'));

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode != 200) {
        print('Error en eliminarUsuario: ${response.body}');
        throw Exception('Fallo al eliminar usuario: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error en eliminarUsuario: $e');
      throw Exception('Fallo al eliminar el usuario: $e');
    }
  }

  Future<List<Usuario>> obtenerUsuarios() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/usuario'));
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = jsonDecode(response.body);
        final List<Usuario> usuarios =
            jsonResponse.map((data) => Usuario.fromJson(data)).toList();
        return usuarios;
      } else {
        print('Error al obtener usuarios: ${response.body}');
        throw Exception('Fallo al obtener usuarios: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error al obtener usuarios: $e');
      throw Exception('Fallo al obtener usuarios: $e');
    }
  }
}
