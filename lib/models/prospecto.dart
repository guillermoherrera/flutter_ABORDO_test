class Prospecto{
  final String nombre;
  final String primerApellido;
  final String segundoApellido;
  final String fechaNacimiento;
  final String sexo;
  
  final String calle;
  final String noExterior;
  final String colonia;
  final String ciudad;
  final String cp;
  final String estado;

  Prospecto({
    required this.nombre, 
    required this.primerApellido, 
    required this.segundoApellido, 
    required this.fechaNacimiento, 
    required this.sexo, 
    required this.calle, 
    required this.noExterior, 
    required this.colonia, 
    required this.ciudad, 
    required this.cp, 
    required this.estado
  });

  Prospecto copyWith({
    String? nombre,
    String? primerApellido,
    String? segundoApellido,
    String? fechaNacimiento,
    String? sexo,
    String? calle,
    String? noExterior,
    String? colonia,
    String? ciudad,
    String? cp,
    String? estado,
  }) => Prospecto(
    nombre: nombre ?? this.nombre, 
    primerApellido: primerApellido ?? this.primerApellido, 
    segundoApellido: segundoApellido ?? this.segundoApellido, 
    fechaNacimiento: fechaNacimiento ?? this.fechaNacimiento, 
    sexo: sexo ?? this.sexo, 
    calle: calle ?? this.calle, 
    noExterior: noExterior ?? this.noExterior, 
    colonia: colonia ?? this.colonia, 
    ciudad: ciudad ?? this.ciudad, 
    cp: cp ?? this.cp, 
    estado: estado ?? this.estado);
}