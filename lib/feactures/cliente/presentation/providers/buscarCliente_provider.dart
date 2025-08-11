import 'package:cargaproductos/feactures/cliente/domain/domain.dart';
import 'package:cargaproductos/feactures/cliente/infrastructure/errors/auth_errors.dart';
import 'package:cargaproductos/feactures/cliente/presentation/providers/clientes_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final clienteInfoProvier = StateNotifierProvider<UsuarioMapNotifier, Map<String, User>>((ref){

  final getUsuario = ref.watch(clienteRepositoryProvider).getUsuario;

  return UsuarioMapNotifier(getUsuario: getUsuario);

});

typedef GetUsuarioCallBack = Future<User>Function(String telefono);

class UsuarioMapNotifier extends StateNotifier<Map<String, User>>{
  final GetUsuarioCallBack getUsuario;

  UsuarioMapNotifier({
    required this.getUsuario,
  }) : super({});

  Future<void> loadUser(String telefono) async {
      if(state[telefono] != null) return;

     try{
        final user = await getUsuario(telefono);

        state = {...state, telefono: user};
     } on CustomError catch (e) {
      print(e);
     // logout( e.message );
    } catch (e){
      print(e);
      //logout( 'Error no controlado' );
    }
  
  }
  
}