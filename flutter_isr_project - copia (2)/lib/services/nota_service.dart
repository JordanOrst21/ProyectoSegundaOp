import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_isr_project/models/nota.dart';
import 'package:flutter_isr_project/models/usuario.dart';

class NotaService {
  final String _baseUrl = 'http://localhost:8898' ;

  Future<List<Nota>> obtenerNotasPorUsuarioID(int usuarioID) async {
    final response =
        await http.get(Uri.parse('$_baseUrl/usuarios/$usuarioID/notas'));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Nota> notasList =
          body.map((dynamic item) => Nota.fromJson(item)).toList();
      return notasList;
    } else {
      throw Exception('Fallo al obtener las notas');
    }
  }

  Future<Nota> obtenerNotaPorID(int usuarioID, int id) async {
    final response =
        await http.get(Uri.parse('$_baseUrl/usuarios/$usuarioID/notas/$id'));

    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      Nota nota = Nota.fromJson(body);
      return nota;
    } else {
      throw Exception('Fallo al obtener la nota');
    }
  }

  Future<Nota> crearNota(
      int usuarioID, String titulo, String descripcion) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/usuarios/$usuarioID/notas'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        'titulo': titulo,
        'descripcion': descripcion,
      }),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      Nota nuevaNota = Nota.fromJson(body);
      return nuevaNota;
    } else {
      throw Exception('Fallo al crear la nota');
    }
  }

  Future<Nota> actualizarNota(
      int usuarioID, int id, String titulo, String descripcion) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/usuarios/$usuarioID/notas/$id'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        'titulo': titulo,
        'descripcion': descripcion,
      }),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      Nota notaActualizada = Nota.fromJson(body);
      return notaActualizada;
    } else {
      throw Exception('Fallo al actualizar la nota');
    }
  }

  Future<void> eliminarNota(int usuarioID, int id) async {
    final response =
        await http.delete(Uri.parse('$_baseUrl/usuarios/$usuarioID/notas/$id'));

    if (response.statusCode != 200) {
      throw Exception('Fallo al eliminar la nota');
    }
  }

  Future<List<Nota>> obtenerNotasPorUsuario(int usuarioId) async {
    final response =
        await http.get(Uri.parse('$_baseUrl/usuarios/$usuarioId/notas'));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Nota> notasList =
          body.map((dynamic item) => Nota.fromJson(item)).toList();
      return notasList;
    } else {
      throw Exception('Fallo al obtener las notas');
    }
  }

  Future<Usuario> obtenerUsuarioPorEmail(String email) async {
    final response =
        await http.get(Uri.parse('$_baseUrl/usuarios?email=$email'));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      if (body.isNotEmpty) {
        return Usuario.fromJson(body[0]);
      } else {
        throw Exception('Usuario no encontrado');
      }
    } else {
      throw Exception('Fallo al obtener el usuario');
    }
  }
}
