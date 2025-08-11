import 'package:cargaproductos/feactures/cliente/domain/domain.dart';

class ClientRepositoryImpl extends AuthRepository{
  final AuthdataSource dataSource;

  ClientRepositoryImpl(this.dataSource);
    
  @override
  Future<User> register(String telefono, String nombre, String direccion) {
    // Implement the logic to register a new user
    return dataSource.register(
      telefono, nombre, direccion
      );
  }

  @override
  Future<User> getUsuario (String telefono){
    return dataSource.getUsuario(
      telefono: telefono
    );
  }

}
