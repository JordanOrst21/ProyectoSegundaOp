import 'package:flutter/cupertino.dart';
import 'package:flutter_isr_project/models/usuario.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EditarUsuarioScreen extends StatefulWidget {
  final Usuario usuario;

  const EditarUsuarioScreen({Key? key, required this.usuario})
      : super(key: key);

  @override
  _EditarUsuarioScreenState createState() => _EditarUsuarioScreenState();
}

class _EditarUsuarioScreenState extends State<EditarUsuarioScreen> {
  late TextEditingController _nombreController;
  late TextEditingController _correoController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _nombreController = TextEditingController(text: widget.usuario.nombre);
    _correoController = TextEditingController(text: widget.usuario.correo);
    _passwordController = TextEditingController(text: widget.usuario.password);
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _correoController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Editar Usuario'),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CupertinoTextField(
                controller: _nombreController,
                placeholder: 'Nombre',
              ),
              SizedBox(height: 20),
              CupertinoTextField(
                controller: _correoController,
                placeholder: 'Correo',
              ),
              SizedBox(height: 20),
              CupertinoTextField(
                controller: _passwordController,
                placeholder: 'Contraseña',
                obscureText: true,
              ),
              SizedBox(height: 20),
              CupertinoButton(
                onPressed: () {
                  _guardarCambios();
                },
                child: Text('Guardar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _guardarCambios() async {
    final String _baseUrl = "http://localhost:8898";

    try {
      final response = await http.put(
        Uri.parse('$_baseUrl/usuario/${widget.usuario.id}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'nombre': _nombreController.text,
          'correo': _correoController.text,
          'password': _passwordController.text,
        }),
      );

      if (response.statusCode == 200) {
        Navigator.pop(context);
      } else {
        print('Error en guardar cambios: ${response.body}');
        throw Exception(
            'Fallo al guardar los cambios: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error en guardar cambios: $e');
      throw Exception('Fallo al guardar los cambios: $e');
    }
  }
}
