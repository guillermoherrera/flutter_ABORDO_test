

import 'package:formz/formz.dart';

enum UsuarioError {empty, length}

class Usuario extends FormzInput<String, UsuarioError>{
  const Usuario.pure() : super.pure('');
  
  const Usuario.dirty(String value) : super.dirty(value);

  String? get errorMessage{
    if(isValid || isPure) return null;

    if(displayError == UsuarioError.empty) return 'El usuario es requerido';
    if(displayError == UsuarioError.length) return 'Minimo 6 caracteres';

    return null;
  }

  @override
  UsuarioError? validator(String value) {
    if(value.isEmpty || value.trim().isEmpty) return UsuarioError.empty;
    if(value.length < 6) return UsuarioError.length;

    //throw UnimplementedError();
    return null;
  }
}