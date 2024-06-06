import 'package:postgres/postgres.dart';

void main() async {
  // Configuración de la conexión
  final connection = PostgreSQLConnection(
    'localhost', // host
    5432, // port
    'proyecto', // database name
    username: 'root', // username
    password: 'root', // password
  );

  try {
    // Abrir la conexión
    await connection.open();
    print('Connected to the database');

    // Cierra la conexión
    await connection.close();
  } catch (e) {
    print('Failed to connect to the database: $e');
  }
}
