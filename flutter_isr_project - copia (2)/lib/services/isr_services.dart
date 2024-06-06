import 'dart:convert';

import 'package:flutter_isr_project/models/rango_isr.dart';
import 'package:http/http.dart' as http;

class ISRService {
  final String _baseUrl = 'http://localhost:8898';

  Future<List<RangoISR>> obtenerRangoISR() async {
    final response = await http.get(Uri.parse('$_baseUrl/isr'));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<RangoISR> isrList =
          body.map((dynamic item) => RangoISR.fromJson(item)).toList();

      return isrList;
    } else {
      throw Exception('Fallo al obtener los rangos ISR');
    }
  }

  Future<RangoISR> obtenerRangoISRPorCantidad(double cantidad) async {
    final response = await http.get(Uri.parse('$_baseUrl/isr/$cantidad'));

    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      RangoISR isr = RangoISR.fromJson(body);
      return isr;
    } else {
      throw Exception('Fallo al obtener los rangos ISR');
    }
  }
}
