import 'package:logging/logging.dart';
import 'package:isr_dart24/isr_dart24.dart';
import 'package:isr_dart24/models/usuario.dart';

class UsuarioController extends ResourceController {
  UsuarioController(this.context);
  final ManagedContext context;

  @Operation.get()
  Future<Response> getAll() async {
    print('Entrando en el método getAll()'); // Agrega un log de entrada
    final usuarioQuery = Query<Usuario>(context);
    final usuarios = await usuarioQuery.fetch();

    return Response.ok(usuarios);
  }

  @Operation.get('id')
  Future<Response> getByID(@Bind.path('id') int id) async {
    final usuarioQuery = Query<Usuario>(context)
      ..where((u) => u.id).equalTo(id);

    final usuario = await usuarioQuery.fetchOne();

    if (usuario == null) {
      return Response.notFound();
    }
    return Response.ok(usuario);
  }

  @Operation.post()
  Future<Response> addUsuario() async {
    print('Entrando en el método POST()');
    final Map<String, dynamic>? body = await request?.body.decode();

    if (body == null) {
      return Response.badRequest(body: {'error': 'Request body is missing'});
    }

    final String nombre = body['nombre']?.toString() ?? ''; // Cambiar a String
    final String correo = body['correo']?.toString() ?? ''; // Cambiar a String
    final String password =
        body['password']?.toString() ?? ''; // Cambiar a String

    if (nombre.isEmpty || correo.isEmpty || password.isEmpty) {
      return Response.badRequest(
          body: {'error': 'Nombre, correo or password is missing'});
    }

    final nuevoUsuario = Usuario()
      ..nombre = nombre
      ..correo = correo
      ..password = password;

    final query = Query<Usuario>(context)..values = nuevoUsuario;

    final insertedUsuario = await query.insert();

    if (insertedUsuario == null) {
      return Response.serverError(body: {'error': 'Error inserting usuario'});
    }

    return Response.ok(insertedUsuario);
  }

  // @Operation.post()
  // Future<Response> login() async {
  //   print('Entrando en el método POST()');
  //   final Map<String, dynamic>? body = await request?.body.decode();
  //   print("Correo = " + body?['correo']);
  //   print("Password = " + body?['password']);

  //   final String correo = body?['correo']?.toString() ?? ''; // Cambiar a String
  //   final String password =
  //       body?['password']?.toString() ?? ''; // Cambiar a String

  //   if (correo.isEmpty || password.isEmpty) {
  //     return Response.badRequest(
  //         body: {'error': 'Correo or password is missing'});
  //   }

  //   final usuarioQuery = Query<Usuario>(context)
  //     ..where((u) => u.correo).equalTo(correo)
  //     ..where((u) => u.password).equalTo(password);

  //   final usuario = await usuarioQuery.fetchOne();

  //   if (usuario == null) {
  //     // Devuelve un booleano en lugar del usuario
  //     return Response.ok({'authenticated': false});
  //   }

  //   // Devuelve un booleano en lugar del usuario
  //   return Response.ok({'authenticated': true});
  // }

  @Operation.put('id')
  Future<Response> updateUsuario(@Bind.path('id') int id) async {
    final Map<String, dynamic>? body = await request?.body.decode();

    if (body == null) {
      return Response.badRequest(body: {'error': 'Request body is missing'});
    }

    final nombre = body['nombre'] as String?;
    final correo = body['correo'] as String?;
    final password = body['password'] as String?;

    if (nombre == null || correo == null || password == null) {
      return Response.badRequest(
          body: {'error': 'Nombre, correo or password is missing'});
    }

    final query = Query<Usuario>(context)
      ..where((usuario) => usuario.id).equalTo(id)
      ..values.nombre = nombre
      ..values.correo = correo
      ..values.password = password;

    final updatedUsuario = await query.updateOne();

    if (updatedUsuario == null) {
      return Response.notFound(body: {'error': 'Usuario not found'});
    }

    return Response.ok(updatedUsuario);
  }

  @Operation.delete('id')
  Future<Response> deleteUsuario(@Bind.path('id') int id) async {
    final query = Query<Usuario>(context)
      ..where((usuario) => usuario.id).equalTo(id);

    final deletedCount = await query.delete();

    if (deletedCount == 0) {
      return Response.notFound(body: {'error': 'Usuario not found'});
    }

    return Response.ok({'message': 'Usuario deleted'});
  }
}
