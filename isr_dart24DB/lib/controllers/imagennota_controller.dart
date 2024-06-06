import 'package:isr_dart24/isr_dart24.dart';
import 'package:isr_dart24/models/imagenNota.dart';
import 'package:isr_dart24/models/nota.dart';

class ImagenNotaController extends ResourceController {
  final ManagedContext context;

  ImagenNotaController(this.context);

  @Operation.get()
  Future<Response> getAllImagenesNotas() async {
    final imagenNotaQuery = Query<ImagenNota>(context);
    final imagenesNotas = await imagenNotaQuery.fetch();

    return Response.ok(imagenesNotas);
  }

  @Operation.get('id')
  Future<Response> getImagenNotaByID(@Bind.path('id') int id) async {
    final imagenNotaQuery = Query<ImagenNota>(context)
      ..where((i) => i.id).equalTo(id);
    final imagenNota = await imagenNotaQuery.fetchOne();

    if (imagenNota == null) {
      return Response.notFound();
    }

    return Response.ok(imagenNota);
  }

  @Operation.get('nota_id')
  Future<Response> getImagenesByNotaID(@Bind.path('nota_id') int notaId) async {
    final imagenNotaQuery = Query<ImagenNota>(context)
      ..where((i) => i.nota!.id).equalTo(notaId);
    final imagenesNotas = await imagenNotaQuery.fetch();

    return Response.ok(imagenesNotas);
  }

  @Operation.put('id')
  Future<Response> updateImagenNota(
    @Bind.path('id') int id,
    @Bind.query('url') String url,
  ) async {
    final imagenNotaQuery = Query<ImagenNota>(context)
      ..where((i) => i.id).equalTo(id)
      ..values.url = url;

    final updatedImagenNota = await imagenNotaQuery.updateOne();

    if (updatedImagenNota == null) {
      return Response.notFound();
    }

    return Response.ok(updatedImagenNota);
  }

  @Operation.delete('id')
  Future<Response> deleteImagenNotaByID(@Bind.path('id') int id) async {
    final imagenNotaQuery = Query<ImagenNota>(context)
      ..where((i) => i.id).equalTo(id);
    final deletedCount = await imagenNotaQuery.delete();

    if (deletedCount == 0) {
      return Response.notFound();
    }

    return Response.ok({'message': 'ImagenNota eliminada'});
  }
}
