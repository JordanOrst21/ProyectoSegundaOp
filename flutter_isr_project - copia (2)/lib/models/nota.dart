class Nota {
  int? id;
  String titulo;
  String descripcion;
  int usuarioId;

  Nota({
    this.id,
    required this.titulo,
    required this.descripcion,
    required this.usuarioId,
  });

  factory Nota.fromJson(Map<String, dynamic> json) {
    return Nota(
      id: json['id'],
      titulo: json['titulo'],
      descripcion: json['descripcion'],
      usuarioId: json['usuario_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titulo': titulo,
      'descripcion': descripcion,
      'usuario_id': usuarioId,
    };
  }
}
