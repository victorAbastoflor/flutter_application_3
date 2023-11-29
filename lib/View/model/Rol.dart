class Rol {
  final String id;
  final String nameRole;

  Rol({required this.id, required this.nameRole});

  factory Rol.fromMap(Map<String, dynamic> map) {
    return Rol(
      id: map['Id'] ?? '',
      nameRole: map['NameRole'] ?? '', 
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Id': id,
      'NameRole': nameRole,
    };
  }
}