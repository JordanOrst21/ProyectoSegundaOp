import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AgregarUsuarioScreen extends StatelessWidget {
  const AgregarUsuarioScreen({Key? key}) : super(key: key);

  final String apiUrl =
      "http://localhost:8898/usuario"; // URL para crear usuario

  Future<void> guardarUsuario(
      String nombre, String correo, String password) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(
            {'nombre': nombre, 'correo': correo, 'password': password}),
      );

      if (response.statusCode == 200) {
        // Si el usuario se crea correctamente, puedes mostrar un mensaje de éxito o realizar otra acción
        print('Usuario creado exitosamente');
      } else {
        // Si hay un error al crear el usuario, puedes manejarlo aquí
        print('Error al crear el usuario: ${response.statusCode}');
      }
    } catch (e) {
      // Si ocurre un error en la solicitud, puedes manejarlo aquí
      print('Error en guardarUsuario: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    String nombre = '';
    String correo = '';
    String password = '';

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Agregar Usuario'),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                onChanged: (value) => nombre = value,
                decoration: InputDecoration(labelText: 'Nombre'),
              ),
              SizedBox(height: 16.0),
              TextField(
                onChanged: (value) => correo = value,
                decoration: InputDecoration(labelText: 'Correo'),
              ),
              SizedBox(height: 16.0),
              TextField(
                onChanged: (value) => password = value,
                decoration: InputDecoration(labelText: 'Contraseña'),
                obscureText: true,
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Llama a la función para guardar el usuario cuando se presiona el botón
                  guardarUsuario(nombre, correo, password);
                },
                child: Text('Guardar Usuario'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
