import 'package:cargaproductos/feactures/cliente/domain/entities/user.dart';
import 'package:cargaproductos/feactures/cliente/infrastructure/models/user/usuariodb.dart';

class UserMapper {

  static User userJsonToEntity(Usuario usuariodb) => User(
      uid: usuariodb.uid,
      nombre: usuariodb.nombre,
      telefono: usuariodb.telefono,
      dinero: usuariodb.dinero,
      direccion: usuariodb.direccion
    );
}

// class UserMapper {

//   static userJsonToEntity(Map<String, dynamic> json) => User(
//       uid: json['uid'],
//       nombre: json['nombre'],
//       telefono: json['telefono'],
//       dinero: json['dinero'],
//       direccion: json['direccion']
//     );
// }