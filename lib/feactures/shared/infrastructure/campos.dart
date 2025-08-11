import 'package:formz/formz.dart';

// Define input validation errors
enum CampoError { empty, length }

// Extend FormzInput and provide the input type and error type.
class Campo extends FormzInput<String, CampoError> {

  static final RegExp emailRegExp = RegExp(
    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
  );

  // Call super.pure to represent an unmodified form input.
  const Campo.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const Campo.dirty( String value ) : super.dirty(value);



  String? get errorMessage {
    if ( isValid || isPure ) return null;

    if ( displayError == CampoError.empty ) return 'El campo es requerido';
    if ( displayError == CampoError.length ) return 'Mínimo 3 caracteres';

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  CampoError? validator(String value) {
    
    if ( value.isEmpty || value.trim().isEmpty ) return CampoError.empty;
    if ( value.length < 3 ) return CampoError.length;

    return null;
  }
}