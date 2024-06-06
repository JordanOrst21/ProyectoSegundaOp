import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_isr_project/screens/ImagenNotaScreen.dart';
import 'package:http/http.dart' as http;

class ListaNotasScreen extends StatefulWidget {
  final int usuarioID;

  const ListaNotasScreen({Key? key, required this.usuarioID}) : super(key: key);

  @override
  _ListaNotasScreenState createState() => _ListaNotasScreenState();
}

class _ListaNotasScreenState extends State<ListaNotasScreen> {
  List<dynamic> notas = [];

  @override
  void initState() {
    super.initState();
    _fetchNotas();
  }

  Future<void> _fetchNotas() async {
    final url =
        Uri.parse('http://localhost:8898/usuario/${widget.usuarioID}/nota');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      setState(() {
        notas = jsonResponse;
      });
    } else {
      print('Error al cargar las notas: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text('Notas'),
        ),
        child: SafeArea(
          child: ListView.builder(
            itemCount: notas.length,
            itemBuilder: (context, index) {
              final nota = notas[index];
              final color = _generateColor(index);
              return Card(
                color: color,
                elevation: 2,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) =>
                            ImagenNotaScreen(notaId: nota['id']),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          nota['titulo'],
                          style: CupertinoTheme.of(context)
                              .textTheme
                              .textStyle
                              .copyWith(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          nota['descripcion'],
                          style: CupertinoTheme.of(context)
                              .textTheme
                              .textStyle
                              .copyWith(
                                fontSize: 16,
                              ),
                        ),
                        SizedBox(height: 8),
                        Container(
                          height: 1,
                          color: CupertinoColors.separator,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
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
