import 'package:conduit/conduit.dart';
import 'package:isr_dart24/isr_dart24.dart';
import 'package:isr_dart24/models/usuario.dart';
import 'package:isr_dart24/models/imagenNota.dart';

import 'package:conduit/conduit.dart';
import 'package:isr_dart24/models/usuario.dart';
import 'package:isr_dart24/models/imagenNota.dart';

@Table(name: 'nota')
class _Nota {
  @primaryKey
  int? id;

  @Column(nullable: false)
  String? titulo;

  @Column(nullable: false)
  String? descripcion;

  @Relate(#notas)
  Usuario? usuario;

  ManagedSet<ImagenNota>? imagenes;
}

class Nota extends ManagedObject<_Nota> implements _Nota {}
