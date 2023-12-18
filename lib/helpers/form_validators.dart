class FormValidators{
  
  static String? existValidator(value) => (value != null && value.isNotEmpty) ? null : 'Este campo es requerido' ;

  static String? lengthValidator(value, length) => (value != null && value.length >= length) ? null : 'Este campo requiere $length caracteres minimo' ;
  
  static String? emailValidator(value){
    String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp  = RegExp(pattern);
    return regExp.hasMatch(value ?? '') ? null : 'El campo ingresado NO tiene formato de correo' ;
  }
}