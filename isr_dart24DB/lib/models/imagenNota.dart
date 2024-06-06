import 'package:conduit/conduit.dart';
import 'package:isr_dart24/isr_dart24.dart';
import 'package:isr_dart24/models/nota.dart';

@Table(name: 'imagen_nota')
class _ImagenNota {
  @primaryKey
  int? id;

  @Relate(#imagenes)
  Nota? nota;

  @Column(nullable: false, databaseType: ManagedPropertyType.string)
  String? url;
}

class ImagenNota extends ManagedObject<_ImagenNota> implements _ImagenNota {}
