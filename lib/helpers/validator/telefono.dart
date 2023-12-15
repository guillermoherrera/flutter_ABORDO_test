

import 'package:formz/formz.dart';

enum TelefonoError {empty, length}

class Telefono extends FormzInput<String, TelefonoError>{
  const Telefono.pure() : super.pure('');
  
  const Telefono.dirty(String value) : super.dirty(value);

  String? get errorMessage{
    if(isValid || isPure) return null;

    if(displayError == TelefonoError.empty) return 'El Telefono es requerido';
    if(displayError == TelefonoError.length) return 'Debe ser a 10 digitos';

    return null;
  }

  @override
  TelefonoError? validator(String value) {
    if(value.isEmpty || value.trim().isEmpty) return TelefonoError.empty;
    if(value.length != 10) return TelefonoError.length;

    //throw UnimplementedError();
    return null;
  }
}