import 'dart:typed_data';
class Prospecto{
  final String? nombre;
  final String? primerApellido;
  final String? segundoApellido;
  final String? fechaNacimiento;
  final String? sexo;
  
  final String? calle;
  final String? noExterior;
  final String? colonia;
  final String? ciudad;
  final String? cp;
  final String? estado;

  final Uint8List? image;

  Prospecto({
    this.nombre, 
    this.primerApellido, 
    this.segundoApellido, 
    this.fechaNacimiento, 
    this.sexo, 
    this.calle, 
    this.noExterior, 
    this.colonia, 
    this.ciudad, 
    this.cp, 
    this.estado,
    this.image,
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
    Uint8List? image,
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
    estado: estado ?? this.estado,
    image: image ?? this.image);
}