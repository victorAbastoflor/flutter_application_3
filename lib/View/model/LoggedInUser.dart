class LoggedInUser {
  final String contrasenia;
  final String usuario;
  final String nombre;
  final String tipoRol;

  LoggedInUser({
    required this.contrasenia,
    required this.usuario,
    required this.nombre,
    required this.tipoRol,
  });

  factory LoggedInUser.fromMap(Map<String, dynamic> map) {
    return LoggedInUser(
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
