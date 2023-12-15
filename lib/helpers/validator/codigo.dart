

import 'package:formz/formz.dart';

enum CodigoError {empty, length}

class Codigo extends FormzInput<String, CodigoError>{
  const Codigo.pure() : super.pure('');
  
  const Codigo.dirty(String value) : super.dirty(value);

  String? get errorMessage{
    if(isValid || isPure) return null;

    if(displayError == CodigoError.empty) return 'El Codigo es requerido';
    if(displayError == CodigoError.length) return 'Minimo 8 caracteres';

    return null;
  }

  @override
  CodigoError? validator(String value) {
    if(value.isEmpty || value.trim().isEmpty) return CodigoError.empty;
    if(value.length < 8) return CodigoError.length;

    //throw UnimplementedError();
    return null;
  }
}