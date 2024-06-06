import 'package:flutter/cupertino.dart';
import 'package:flutter_isr_project/models/nota.dart';
import 'package:flutter_isr_project/services/imagennota_service.dart';
import 'package:flutter_isr_project/models/imagenNota.dart';

class NotaDetailScreen extends StatefulWidget {
  final Nota nota;

  const NotaDetailScreen({required this.nota, super.key});

  @override
  State<NotaDetailScreen> createState() => _NotaDetailScreenState();
}

class _NotaDetailScreenState extends State<NotaDetailScreen> {
  final ImagenNotaService _imagenNotaService = ImagenNotaService();
  List<ImagenNota> _imagenesNotas = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _cargarImagenesNotas();
  }

  void _cargarImagenesNotas() async {
    try {
      final imagenesNotas =
          await _imagenNotaService.obtenerTodasImagenesNotas();
      setState(() {
        _imagenesNotas =
            imagenesNotas.where((img) => img.notaId == widget.nota.id).toList();
        _isLoading = false;
      });
    } catch (e) {
      print('Error al obtener las imágenes de las notas: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(widget.nota.titulo ?? ''),
      ),
      child: SafeArea(
        child: _isLoading
            ? Center(child: CupertinoActivityIndicator())
            : SingleChildScrollView(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.nota.titulo ?? '',
                      style: CupertinoTheme.of(context)
                          .textTheme
                          .navTitleTextStyle,
                    ),
                    SizedBox(height: 16),
                    Text(
                      widget.nota.descripcion ?? '',
                      style: CupertinoTheme.of(context).textTheme.textStyle,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Imágenes:',
                      style: CupertinoTheme.of(context)
                          .textTheme
                          .textStyle
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    ..._imagenesNotas.map((imagenNota) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Image.network(imagenNota.url),
                      );
                    }).toList(),
                  ],
                ),
              ),
      ),
    );
  }
}
