import 'dart:typed_data';
class Prospecto{
  final int? folioRegistro;
  final String? idCliente;

  final String? nombre;
  final String? primerApellido;
  final String? segundoApellido;
  final String? fechaNacimiento;
  final String? sexo;
  
  final String? calle;
  final String? noExterior;
  final String? noInterior;
  final String? colonia;
  final String? delegacion;
  final String? ciudad;
  final String? cp;
  final String? estado;

  final String? telFijo;
  final String? telCelular;
  final String? observacion;

  final Uint8List? image;

  Prospecto({
    this.folioRegistro, 
    this.idCliente, 
    this.nombre, 
    this.primerApellido, 
    this.segundoApellido, 
    this.fechaNacimiento, 
    this.sexo, 
    this.calle, 
    this.noExterior, 
    this.noInterior, 
    this.colonia, 
    this.delegacion, 
    this.ciudad, 
    this.cp, 
    this.estado,
    this.telFijo,
    this.telCelular,
    this.observacion,
    this.image,
  });

  Prospecto copyWith({
    int? folioRegistro,
    String? idCliente,
    String? nombre,
    String? primerApellido,
    String? segundoApellido,
    String? fechaNacimiento,
    String? sexo,
    String? calle,
    String? noExterior,
    String? noInterior,
    String? colonia,
    String? delegacion,
    String? ciudad,
    String? cp,
    String? estado,
    String? telFijo,
    String? telCelular,
    String? observacion,
    Uint8List? image,
  }) => Prospecto(
    folioRegistro: folioRegistro ?? this.folioRegistro, 
    idCliente: idCliente ?? this.idCliente, 
    nombre: nombre ?? this.nombre, 
    primerApellido: primerApellido ?? this.primerApellido, 
    segundoApellido: segundoApellido ?? this.segundoApellido, 
    fechaNacimiento: fechaNacimiento ?? this.fechaNacimiento, 
    sexo: sexo ?? this.sexo, 
    calle: calle ?? this.calle, 
    noExterior: noExterior ?? this.noExterior, 
    noInterior: noInterior ?? this.noInterior, 
    ciudad: ciudad ?? this.ciudad, 
    delegacion: delegacion ?? this.delegacion, 
    cp: cp ?? this.cp, 
    estado: estado ?? this.estado,
    telFijo: telFijo ?? this.telFijo,
    telCelular: telCelular ?? this.telCelular,
    observacion: observacion ?? this.observacion,
    image: image ?? this.image);
}