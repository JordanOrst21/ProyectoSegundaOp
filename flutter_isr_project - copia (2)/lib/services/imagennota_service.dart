import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_isr_project/models/imagenNota.dart';

class ImagenNotaService {
  final String _baseUrl = 'http://localhost:8898';

  Future<List<ImagenNota>> obtenerTodasImagenesNotas() async {
    final response = await http.get(Uri.parse('$_baseUrl/imagen_notas'));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<ImagenNota> imagenesNotasList =
          body.map((dynamic item) => ImagenNota.fromJson(item)).toList();
      return imagenesNotasList;
    } else {
      throw Exception('Fallo al obtener las imagenes de las notas');
    }
  }

  Future<ImagenNota> obtenerImagenNotaPorID(int id) async {
    final response = await http.get(Uri.parse('$_baseUrl/imagen_notas/$id'));

    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      ImagenNota imagenNota = ImagenNota.fromJson(body);
      return imagenNota;
    } else {
      throw Exception('Fallo al obtener la imagen de la nota');
    }
  }

  Future<ImagenNota> crearImagenNota(int notaID, String url) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/imagen_notas'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        'nota_id': notaID,
        'url': url,
      }),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      ImagenNota nuevaImagenNota = ImagenNota.fromJson(body);
      return nuevaImagenNota;
    } else {
      throw Exception('Fallo al crear la imagen de la nota');
    }
  }

  Future<ImagenNota> actualizarImagenNota(int id, String url) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/imagen_notas/$id'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        'url': url,
      }),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      ImagenNota imagenNotaActualizada = ImagenNota.fromJson(body);
      return imagenNotaActualizada;
    } else {
      throw Exception('Fallo al actualizar la imagen de la nota');
    }
  }

  Future<void> eliminarImagenNota(int id) async {
    final response = await http.delete(Uri.parse('$_baseUrl/imagen_notas/$id'));

    if (response.statusCode != 200) {
      throw Exception('Fallo al eliminar la imagen de la nota');
    }
  }
}
