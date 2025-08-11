
import 'package:cargaproductos/feactures/cliente/infrastructure/datasources/auth_datasource_impl.dart';
import 'package:cargaproductos/feactures/cliente/infrastructure/repositories/user_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



//Este repositorio es el que se inyecta en el provider y es inmutable
// y no se puede modificar. Se utiliza para obtener las tareas de la base de datos
// y se utiliza en el provider de tareas para obtener las tareas
final clienteRepositoryProvider = Provider((ref){

  return ClientRepositoryImpl(AuthDatasourceImpl());

});