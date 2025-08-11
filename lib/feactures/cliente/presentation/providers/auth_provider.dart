import 'package:cargaproductos/feactures/cliente/domain/domain.dart';
import 'package:cargaproductos/feactures/cliente/infrastructure/errors/auth_errors.dart';
import 'package:cargaproductos/feactures/cliente/infrastructure/infrastructure.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



final authProvider = StateNotifierProvider<AuthNotifier, AuthState>(
    (ref){
      final authRepository = AuthRepositoryImpl();

      return AuthNotifier(
        authRepository: authRepository
      );
    }
  ); 

class AuthNotifier extends StateNotifier<AuthState>{

  final AuthRepository authRepository;

  AuthNotifier({
    required this.authRepository
  }) : super(AuthState());

  Future<void> register (String telefono, String nombre, String direccion)async{
    try{
      await authRepository.register(telefono, nombre, direccion);
      state = state.copyWith(
        responseOk: 'Cliente registrado'
      );
    }
    on CustomError catch (e) {
      print(e);
      logout( e.message );
    } catch (e){
      print(e);
      logout( 'Error no controlado' );
    }
  }

   Future<void> logout([ String? errorMessage ]) async {
    // TODO: limpiar token
    state = state.copyWith(
      authStatus: AuthStatus.noAuthenticated,
      user: null,
      errorMessage: errorMessage
    );
  }

}

enum AuthStatus {checking, authenticated, noAuthenticated}

class AuthState{
  final AuthStatus authStatus;
  final User? user;
  final String errorMessage;
  final String responseOk;

  AuthState({
    this.authStatus = AuthStatus.checking,
    this.user,
    this.errorMessage =  '',
    this.responseOk = ''
    });

    AuthState copyWith({
      AuthStatus? authStatus,
      User? user,
      String? errorMessage,
      String? responseOk
}) => AuthState(
      authStatus: authStatus ?? this.authStatus,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
      responseOk: responseOk ?? this.responseOk
    );
}