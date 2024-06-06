import 'dart:convert';
import 'package:flutter/material.dart'; // Importa el paquete de widgets de Material
import 'package:flutter/cupertino.dart';
import 'package:flutter_isr_project/models/usuario.dart';
import 'package:flutter_isr_project/screens/EditarUsuarioScreen.dart';
import 'package:flutter_isr_project/screens/AgregarUsuarioScreen.dart';
import 'package:flutter_isr_project/screens/ListaNotasScreen.dart'; // Importa la pantalla ListaNotasScreen
import 'package:flutter_isr_project/services/usuario_service.dart';
import 'package:http/http.dart' as http;

class UsuariosListadoScreen extends StatefulWidget {
  const UsuariosListadoScreen({Key? key}) : super(key: key);

  @override
  _UsuariosListadoScreenState createState() => _UsuariosListadoScreenState();
}

class _UsuariosListadoScreenState extends State<UsuariosListadoScreen> {
  late Future<List<Usuario>> _usuariosFuture;

  @override
  void initState() {
    super.initState();
    _usuariosFuture = UsuarioService().obtenerUsuarios();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Row(
          children: [
            Text('Usuarios'),
            SizedBox(width: 8),
            CupertinoButton(
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => AgregarUsuarioScreen(),
                  ),
                );
              },
              child: Icon(CupertinoIcons.add),
            ),
          ],
        ),
      ),
      child: SafeArea(
        child: FutureBuilder<List<Usuario>>(
          future: _usuariosFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CupertinoActivityIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error al cargar los usuarios'),
              );
            } else if (snapshot.hasData) {
              final usuarios = snapshot.data!;
              return ListView.builder(
                itemCount: usuarios.length,
                itemBuilder: (context, index) {
                  final usuario = usuarios[index];
                  final color = _generateColor(index);
                  return Card(
                    color: color,
                    elevation: 2,
                    child: ListTile(
                      title: Text(usuario.nombre),
                      subtitle: Text(usuario.correo),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CupertinoButton(
                            onPressed: () {
                              // Lógica para eliminar el usuario
                              eliminarUsuario(usuario.id!);
                            },
                            child: Icon(CupertinoIcons.delete),
                          ),
                          CupertinoButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) =>
                                      EditarUsuarioScreen(usuario: usuario),
                                ),
                              );
                            },
                            child: Icon(CupertinoIcons.create),
                          ),
                        ],
                      ),
                      onTap: () {
                        // Navegar a ListaNotasScreen pasando el usuarioID
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) =>
                                ListaNotasScreen(usuarioID: usuario.id!),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: Text('No se encontraron usuarios'),
              );
            }
          },
        ),
      ),
    );
  }

  Future<void> eliminarUsuario(int id) async {
    final String _baseUrl = "http://localhost:8898";

    try {
      final response = await http.delete(Uri.parse('$_baseUrl/usuario/$id'));

      if (response.statusCode == 200) {
        print('Usuario eliminado exitosamente');
        setState(() {
          // Refrescar la lista de usuarios después de eliminar uno
          _usuariosFuture = UsuarioService().obtenerUsuarios();
        });
      } else {
        print('Error al eliminar usuario: ${response.statusCode}');
        throw Exception('Fallo al eliminar usuario: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error en eliminarUsuario: $e');
      throw Exception('Fallo al eliminar el usuario: $e');
    }
  }

  Color _generateColor(int index) {
    final colors = [
      Colors.pink[100],
      Colors.blue[100],
      Colors.green[100],
      Colors.orange[100],
      Colors.purple[100],
      Colors.yellow[100],
    ];
    return colors[index % colors.length] ?? Colors.grey[100]!;
  }
}
