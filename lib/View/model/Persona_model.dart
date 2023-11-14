class Persona {
  late String id;
  final String apellidoMaterno;
  final String apellidoPaterno;
  final String carnetIdentidad;
  final String contrasenia;
  final String correoElectronico;
  final String genero;
  final String usuario;
  final String nit;
  final String nombre;
  final String tipoRol;

  Persona({
    required this.apellidoMaterno,
    required this.apellidoPaterno,
    required this.carnetIdentidad,
    required this.contrasenia,
    required this.correoElectronico,
    required this.genero,
    required this.usuario,
    required this.nit,
    required this.nombre,
    required this.tipoRol,
  });

  factory Persona.fromMap(Map<String, dynamic> data, String id) {
    return Persona(
      apellidoMaterno: data['ApellidoMaterno'] ?? '',
      apellidoPaterno: data['ApellidoPaterno'] ?? '',
      carnetIdentidad: data['CarnetIdentidad'] ?? '',
      contrasenia: data['Contrasenia'] ?? '',
      correoElectronico: data['CorreoElectronico'] ?? '',
      genero: data['Genero'] ?? '',
      usuario: data['Usuario'] ?? '',
      nit: data['nit'] ?? '',
      nombre: data['Nombre'] ?? '',
      tipoRol: data['TipoRol'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ApellidoMaterno': apellidoMaterno,
      'ApellidoPaterno': apellidoPaterno,
      'CarnetIdentidad': carnetIdentidad,
      'Contrasenia': contrasenia,
      'CorreoElectronico': correoElectronico,
      'Genero': genero,
      'Usuario': usuario,
      'nit': nit,
      'Nombre': nombre,
      'TipoRol': tipoRol,
    };
  }
}
