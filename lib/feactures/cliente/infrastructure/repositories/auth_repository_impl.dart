import 'package:cargaproductos/feactures/cliente/domain/domain.dart';
import '../infrastructure.dart';

class AuthRepositoryImpl extends AuthRepository{
  final AuthdataSource dataSource;

  AuthRepositoryImpl({
    AuthdataSource? dataSource
  }) : dataSource = dataSource ?? AuthDatasourceImpl();
    
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
