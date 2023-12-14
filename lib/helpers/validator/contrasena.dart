import 'package:formz/formz.dart';

enum ContrasenaError {empty, length}

class Contrasena extends FormzInput<String, ContrasenaError>{
  const Contrasena.pure() : super.pure('');

  const Contrasena.dirty(String value) : super.dirty(value);
  
  String? get errorMessage{
    if(isValid || isPure) return null;

    if(displayError == ContrasenaError.empty) return 'La contraseña es requerida';
    if(displayError == ContrasenaError.length) return 'Minimo 6 caracteres';

    return null;
  }

  @override
  ContrasenaError? validator(String value) {
    if(value.isEmpty || value.trim().isEmpty) return ContrasenaError.empty;
    if(value.length < 6) return ContrasenaError.length;
    return null;
    //throw UnimplementedError();
  }
  
}