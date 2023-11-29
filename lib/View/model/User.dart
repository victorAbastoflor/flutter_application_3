class User {
  final String contrasenia;
  final String usuario;
  final String nombre;
  final String tipoRol;

  User({
    required this.contrasenia,
    required this.usuario,
    required this.nombre,
    required this.tipoRol,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      contrasenia: map['Contrasenia'] ?? '',
      usuario: map['Usuario'] ?? '',
      nombre: map['Nombre'] ?? '',
      tipoRol: map['TipoRol'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Contrasenia': contrasenia,
      'Usuario': usuario,
      'Nombre': nombre,
      'TipoRol': tipoRol,
    };
  }
}
