class Usuario {
    final String nombre;
    final String telefono;
    final int dinero;
    final String uid;
    final String direccion;

    Usuario({
        required this.nombre,
        required this.telefono,
        required this.dinero,
        required this.uid,
        required this.direccion,
    });

    factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        nombre: json["nombre"],
        telefono: json["telefono"],
        dinero: json["dinero"],
        direccion: json["direccion"],
        uid: json["uid"],
    );

    Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "telefono": telefono,
        "dinero": dinero,
        "uid": uid,
        "direccion": direccion // Assuming direccion is optional
    };
}