import 'package:cargaproductos/feactures/cliente/domain/entities/user.dart';

abstract class AuthdataSource
 {
  Future<User> register(
    String telefono,
    String nombre,
    String direccion
  );
  Future<User> getUsuario({String? telefono});
}

