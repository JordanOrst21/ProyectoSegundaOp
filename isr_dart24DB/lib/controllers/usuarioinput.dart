class UsuarioInput {
  String? nombre;
  String? correo;
  String? password;

  UsuarioInput({this.nombre, this.correo, this.password});

  factory UsuarioInput.fromJson(Map<String, dynamic> json) {
    return UsuarioInput(
      nombre: json['nombre'],
      correo: json['correo'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nombre'] = this.nombre;
    data['correo'] = this.correo;
    data['password'] = this.password;
    return data;
  }
}
