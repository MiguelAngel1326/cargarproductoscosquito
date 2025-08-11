import 'package:cargaproductos/config/constants/environment.dart';
import 'package:cargaproductos/feactures/cliente/domain/datasources/auth_datasource.dart';
import 'package:cargaproductos/feactures/cliente/domain/entities/user.dart';
import 'package:cargaproductos/feactures/cliente/infrastructure/errors/auth_errors.dart';
import 'package:cargaproductos/feactures/cliente/infrastructure/mappers/user_mappers.dart';
import 'package:cargaproductos/feactures/cliente/infrastructure/models/user/usuario_response.dart';
import 'package:dio/dio.dart';

class ClienthDatasourceImpl extends AuthdataSource{

  final dio = Dio(
    BaseOptions(
      baseUrl: Environment.apiUrl,
    )
  );



  @override
  Future<User> register(String telefono, String nombre, String direccion) async{
    try{

      final response = await dio.post('/login/new', data:{
        'telefono': telefono,
        'nombre': nombre,
        'direccion': direccion
      });

      final userResponse = UsuarioResponse.fromJson(response.data);

      final User user = UserMapper.userJsonToEntity(userResponse.usuario);

      return user;

    }on DioException catch (e) {
      if( e.response?.statusCode == 400 ){
         throw CustomError(e.response?.data['message'] ?? 'Numero ya registrado' );
      }
      if ( e.type == DioExceptionType.connectionTimeout ){
        throw CustomError('Revisar conexión a internet');
      }
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  Future<User> getUsuario({String? telefono}) async{
    
  try{
      final response = await dio.post('/login/usuario', data:{
        'telefono': telefono
      });

      final usuarioResponse = UsuarioResponse.fromJson(response.data);

      final User user = UserMapper.userJsonToEntity(usuarioResponse.usuario);

      return user;
      
  } on DioException catch (e) {
      if( e.response?.statusCode == 404 ){
         throw CustomError(e.response?.data['message'] ?? 'Numero no registrado' );
    } 
      throw CustomError('No se encontró información');
    } catch (e) {
      throw Exception();
    }
  }
}