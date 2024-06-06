import 'dart:async';
import 'package:conduit/conduit.dart';
import 'package:conduit_postgresql/conduit_postgresql.dart';
import 'package:isr_dart24/controllers/imagennota_controller.dart';
import 'package:isr_dart24/controllers/nota_controller.dart';
import 'package:logging/logging.dart';
import 'package:isr_dart24/config/isr_configuration.dart';
import 'package:isr_dart24/controllers/usuario_controller.dart';
import 'package:isr_dart24/isr_dart24.dart';

class CORSMiddleware extends Controller {
  @override
  FutureOr<RequestOrResponse?> handle(Request request) {
    request.response.headers.add('Access-Control-Allow-Origin', '*');
    request.response.headers
        .add('Access-Control-Allow-Methods', 'POST,GET,PUT,DELETE,OPTIONS');
    request.response.headers
        .add('Access-Control-Allow-Headers', 'Content-Type, Authorization');

    if (request.method == 'OPTIONS') {
      return Response.ok('');
    }
    return request;
  }
}

class IsrDart24Channel extends ApplicationChannel {
  late ManagedContext context;

  @override
  Future<void> prepare() async {
    final config = ISRConfiguration(options!.configurationFilePath!);
    final dbConfig = config.database;
    final dataModel = ManagedDataModel.fromCurrentMirrorSystem();

    try {
      final persistentStore = PostgreSQLPersistentStore(
        dbConfig.username,
        dbConfig.password,
        dbConfig.host,
        dbConfig.port,
        dbConfig.databaseName,
      );

      context = ManagedContext(dataModel, persistentStore);
    } catch (e) {
      print('Error connecting to the database: $e');
      rethrow;
    }

    // Configurar el logger
    hierarchicalLoggingEnabled = true;
    logger.level = Level.INFO;
    logger.onRecord.listen((rec) {
      print('${rec.level.name}: ${rec.time}: ${rec.message}');
      if (rec.error != null) {
        print('${rec.error}');
      }
      if (rec.stackTrace != null) {
        print('${rec.stackTrace}');
      }
    });
  }

  @override
  Controller get entryPoint {
    final router = Router();

    // Agrega el middleware de CORS
    router.route('/*').link(() => CORSMiddleware());

    // Define tus rutas después de CORS
    router.route("/example").linkFunction((request) async {
      return Response.ok({"key": "value"});
    });

    router.route("/usuario").link(() => UsuarioController(context));
    router.route("/usuario/:id").link(() => UsuarioController(context));
    router.route("/usuario/login").link(() => UsuarioController(context));

    router
        .route("/nota/:nota_id/imagen")
        .link(() => ImagenNotaController(context));
    router
        .route("/nota/:nota_id/imagen/:id")
        .link(() => ImagenNotaController(context));

    router.route("/nota").link(() => NotaController(context));
    router.route("/nota/:id").link(() => NotaController(context));
    router
        .route("/usuario/:usuario_id/nota")
        .link(() => NotaController(context));

    return router;
  }
}
