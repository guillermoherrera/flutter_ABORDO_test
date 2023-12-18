class FormValidators{
  
  static String? existValidator(value) => (value != null && value.isNotEmpty) ? null : 'Este campo es requerido' ;

  static String? lengthValidator(value, length) => (value != null && value.length >= length) ? null : 'Este campo requiere $length caracteres minimo' ;
  
  static String? telValidator(value) => (value != null && value.length == 10) ? null : 'El teléfono debe ser a 10 digitos' ;
  
  static String? confirmValidator(value, value2) => (value == value2) ? null : 'Los campos deben coicidir' ;
  
  static String? emailValidator(value){
    String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp  = RegExp(pattern);
    return regExp.hasMatch(value ?? '') ? null : 'El campo ingresado NO tiene formato de correo' ;
  }
}