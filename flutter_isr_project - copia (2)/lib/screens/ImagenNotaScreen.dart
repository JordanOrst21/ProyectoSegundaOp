import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ImagenNota {
  final int id;
  final String url;
  final int notaId;

  ImagenNota({
    required this.id,
    required this.url,
    required this.notaId,
  });

  factory ImagenNota.fromJson(Map<String, dynamic> json) {
    return ImagenNota(
      id: json['id'] ?? 0,
      url: json['url'] ?? '',
      notaId: json['nota']['id'] ?? 0,
    );
  }
}

class ImagenNotaScreen extends StatefulWidget {
  final int notaId;

  const ImagenNotaScreen({Key? key, required this.notaId}) : super(key: key);

  @override
  _ImagenNotaScreenState createState() => _ImagenNotaScreenState();
}

class _ImagenNotaScreenState extends State<ImagenNotaScreen> {
  late Future<List<ImagenNota>> futureImagenes;

  @override
  void initState() {
    super.initState();
    futureImagenes = fetchImagenes();
  }

  Future<List<ImagenNota>> fetchImagenes() async {
    final response = await http
        .get(Uri.parse('http://localhost:8898/nota/${widget.notaId}/imagen'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((imagen) => ImagenNota.fromJson(imagen)).toList();
    } else {
      throw Exception('Failed to load images');
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Imagenes de Nota'),
      ),
      child: FutureBuilder<List<ImagenNota>>(
        future: futureImagenes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CupertinoActivityIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No images found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return CupertinoListTile(
                  leading: Image.network(
                    snapshot.data![index].url,
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  title: Text('Imagen ${snapshot.data![index].id}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class CupertinoListTile extends StatelessWidget {
  final Widget leading;
  final Widget title;

  const CupertinoListTile({required this.leading, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: CupertinoColors.systemGrey4,
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        children: [
          leading,
          SizedBox(width: 10),
          Expanded(child: title),
        ],
      ),
    );
  }
}
