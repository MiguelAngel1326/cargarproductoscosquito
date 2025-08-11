import 'package:cargaproductos/feactures/cliente/presentation/providers/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';

import '../../../shared/infrastructure/campos.dart';
import '../../../shared/infrastructure/phone.dart';

final registryformProvider = StateNotifierProvider.autoDispose<RegistryFormNotifier, RegistryFormState>((ref){

  final registryUserCallback = ref.watch(authProvider.notifier).register;
  return RegistryFormNotifier(
    registryUserCallback: registryUserCallback
  );

});

class RegistryFormNotifier extends StateNotifier<RegistryFormState>{

  final Function (String, String, String) registryUserCallback;

  RegistryFormNotifier({
    required this.registryUserCallback,
  }): super(RegistryFormState());

  onPhoneChanged(String value){
    final newPhone = Phone.dirty(value);
    state = state.copyWith(
      phone: newPhone,
      isValid: Formz.validate([newPhone, state.name, state.address])
    );
  }

  onNameChanged(String value){
    final newName = Campo.dirty(value);
    state = state.copyWith(
      name: newName,
      isValid: Formz.validate([newName, state.phone, state.address])
    );
  }

  onAddressChanged(String value){
    final newAddress = Campo.dirty(value);
    state = state.copyWith(
      address: newAddress,
      isValid: Formz.validate([newAddress, state.phone, state.name])
    );
  }

  onFormSubmit() async{
    _touchEveryField();

    if(!state.isValid) return;
    await registryUserCallback(
      state.phone.value,
      state.name.value,
      state.address.value,
    );
  }

  void clearForm() {
  state = state.copyWith(
    name: Campo.pure(), 
    phone: Phone.pure(),
    address: Campo.pure(),
    isFormPosted: false,
    isValid: false
  );
}

  _touchEveryField(){
    final phone = Phone.dirty(state.phone.value);
    final name = Campo.dirty(state.name.value);
    final address = Campo.dirty(state.address.value);

    state = state.copyWith(
      isFormPosted: true,
      phone: phone,
      name: name,
      address: address,
      isValid: Formz.validate([phone, name, address]),
    );

  }

}

class RegistryFormState{
  final bool isposting;
  final bool isFormPosted;
  final bool isValid;
  final Phone phone;
  final Campo name;
  final Campo address;


  RegistryFormState({
    this.isposting = false, 
    this.isFormPosted = false, 
     this.isValid = false, 
     this.phone = const Phone.pure(),
     this.name = const Campo.pure(),
     this.address = const Campo.pure()
     
});

RegistryFormState copyWith({
  bool? isposting,
  bool? isFormPosted,
  bool? isValid,
  Phone? phone,
  Campo? name,
  Campo? address,
}) => RegistryFormState(
  isposting: isposting ?? this.isposting,
  isFormPosted: isFormPosted ?? this.isFormPosted,
  isValid: isValid ?? this.isValid,
  phone: phone ?? this.phone,
  name: name ?? this.name,
  address: address ?? this.name,
);

  @override
String toString() {
  return '''
RegistryFormState: 
    isposting: $isposting,
    isFormPosted: $isFormPosted,
    isValid: $isValid,
    phone: $phone,
    name: $name,
    address: $address
  ''';
  }
}