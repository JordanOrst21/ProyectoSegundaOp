class Usuario {
  int? id;
  String nombre;
  String correo;
  String password;

  Usuario({
    this.id,
    required this.nombre,
    required this.correo,
    required this.password,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'],
      nombre: json['nombre'],
      correo: json['correo'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'correo': correo,
      'password': password,
    };
  }
}
