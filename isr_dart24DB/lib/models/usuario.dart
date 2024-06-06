import 'package:conduit/conduit.dart';
import 'package:isr_dart24/isr_dart24.dart';
import 'package:isr_dart24/models/nota.dart';

@Table(name: 'usuario')
class _Usuario {
  @primaryKey
  int? id;

  @Column(nullable: false, databaseType: ManagedPropertyType.string)
  String? nombre;

  @Column(nullable: false, databaseType: ManagedPropertyType.string)
  String? correo;

  @Column(nullable: false, databaseType: ManagedPropertyType.string)
  String? password;

  late ManagedSet<Nota> notas;
}

class Usuario extends ManagedObject<_Usuario> implements _Usuario {}
