import 'package:isr_dart24/isr_dart24.dart';
import 'package:isr_dart24/models/imagenNota.dart';
import 'package:isr_dart24/models/nota.dart';
import 'package:isr_dart24/models/usuario.dart';

class NotaController extends ResourceController {
  final ManagedContext context;

  NotaController(this.context);

  @Operation.get('usuario_id')
  Future<Response> getAllNotasByUsuarioID(
      @Bind.path('usuario_id') int usuarioID) async {
    final notaQuery = Query<Nota>(context)
      ..where((n) => n.usuario?.id).equalTo(usuarioID);
    final notas = await notaQuery.fetch();

    return Response.ok(notas);
  }

  @Operation.get('usuario_id', 'id')
  Future<Response> getNotaByID(
    @Bind.path('usuario_id') int usuarioID,
    @Bind.path('id') int id,
  ) async {
    final notaQuery = Query<Nota>(context)
      ..where((n) => n.usuario?.id).equalTo(usuarioID)
      ..where((n) => n.id).equalTo(id);
    final nota = await notaQuery.fetchOne();

    if (nota == null) {
      return Response.notFound();
    }

    return Response.ok(nota);
  }

  @Operation.post('usuario_id')
  Future<Response> createNota(
    @Bind.path('usuario_id') int usuarioID,
    @Bind.body() Nota nuevaNota,
  ) async {
    final usuarioQuery = Query<Usuario>(context)
      ..where((u) => u.id).equalTo(usuarioID);
    final usuario = await usuarioQuery.fetchOne();

    if (usuario == null) {
      return Response.notFound();
    }

    nuevaNota.usuario = usuario;

    final notaQuery = Query<Nota>(context)..values = nuevaNota;
    final insertedNota = await notaQuery.insert();

    return Response.ok(insertedNota);
  }

  @Operation.put('usuario_id', 'id')
  Future<Response> updateNota(
    @Bind.path('usuario_id') int usuarioID,
    @Bind.path('id') int id,
    @Bind.body() Nota updatedNota,
  ) async {
    final notaQuery = Query<Nota>(context)
      ..where((n) => n.usuario?.id).equalTo(usuarioID)
      ..where((n) => n.id).equalTo(id)
      ..values = updatedNota;

    final nota = await notaQuery.updateOne();

    if (nota == null) {
      return Response.notFound();
    }

    return Response.ok(nota);
  }

  @Operation.delete('usuario_id', 'id')
  Future<Response> deleteNotaByID(
    @Bind.path('usuario_id') int usuarioID,
    @Bind.path('id') int id,
  ) async {
    final notaQuery = Query<Nota>(context)
      ..where((n) => n.usuario?.id).equalTo(usuarioID)
      ..where((n) => n.id).equalTo(id);
    final deletedCount = await notaQuery.delete();

    if (deletedCount == 0) {
      return Response.notFound();
    }

    return Response.ok({'message': 'Nota eliminada'});
  }

  @Operation.post('nota_id')
  Future<Response> createImagenNota(
    @Bind.path('nota_id') int notaID,
    @Bind.query('url') String url,
  ) async {
    final nuevaImagenNota = ImagenNota()..url = url;

    final notaQuery = Query<Nota>(context)..where((n) => n.id).equalTo(notaID);
    final nota = await notaQuery.fetchOne();

    if (nota == null) {
      return Response.notFound();
    }

    // Asignar la nota a la nueva imagen
    nuevaImagenNota.nota = nota;

    final imagenNotaQuery = Query<ImagenNota>(context)
      ..values = nuevaImagenNota;
    final insertedImagenNota = await imagenNotaQuery.insert();

    return Response.ok(insertedImagenNota);
  }
}
