// To parse this JSON data, do
//
//     final prospectoObtenerPerfil = prospectoObtenerPerfilFromJson(jsonString);

import 'dart:convert';

ProspectoObtenerPerfil prospectoObtenerPerfilFromJson(String str) => ProspectoObtenerPerfil.fromJson(json.decode(str));

String prospectoObtenerPerfilToJson(ProspectoObtenerPerfil data) => json.encode(data.toJson());

class ProspectoObtenerPerfil {
    DataProspectoObtenerPerfil? data;
    int? error;
    String? resultado;

    ProspectoObtenerPerfil({
        this.data,
        this.error,
        this.resultado,
    });

    factory ProspectoObtenerPerfil.fromJson(Map<String, dynamic> json) => ProspectoObtenerPerfil(
        data: json["data"] != null ? DataProspectoObtenerPerfil.fromJson(json["data"]) : null,
        error: json["error"],
        resultado: json["resultado"],
    );

    Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
        "error": error,
        "resultado": resultado,
    };
}

class DataProspectoObtenerPerfil {
    DateTime fechaRegistro;
    String nombre;
    String descClienteStat;
    int folioRegistro;
    String? color;
    String? direccion;
    int? idNumSucursal;
    String? nomSucursal;
    int? idNumPlaza;
    String? descPlaza;
    String? sexo;
    DateTime? fecNac;
    String? telFijo;
    String? telCelular;
    String? observaciones;

    DataProspectoObtenerPerfil({
      required this.fechaRegistro,
      required this.nombre,
      required this.descClienteStat,
      required this.folioRegistro,
      this.color,
      this.direccion,
      this.idNumSucursal,
      this.nomSucursal,
      this.idNumPlaza,
      this.descPlaza,
      this.sexo,
      this.fecNac,
      this.telFijo,
      this.telCelular,
      this.observaciones,
    });

    factory DataProspectoObtenerPerfil.fromJson(Map<String, dynamic> json) => DataProspectoObtenerPerfil(
        fechaRegistro: DateTime.parse(json["fecha_Registro"]),
        nombre: json["nombre"],
        descClienteStat: json["desc_ClienteStat"],
        folioRegistro: json["folio_Registro"],
        color: json["color"],
        direccion: json["direccion"],
        idNumSucursal: json["id_Num_Sucursal"],
        nomSucursal: json["nom_Sucursal"],
        idNumPlaza: json["id_Num_Plaza"],
        descPlaza: json["desc_Plaza"],
        sexo: json["sexo"],
        fecNac: DateTime.parse(json["fec_Nac"]),
        telFijo: json["tel_Fijo"],
        telCelular: json["tel_Celular"],
        observaciones: json["observaciones"],
    );

    Map<String, dynamic> toJson() => {
        "fecha_Registro": fechaRegistro.toIso8601String(),
        "nombre": nombre,
        "desc_ClienteStat": descClienteStat,
        "color": color,
        "direccion": direccion,
        "idNumSucursal": idNumSucursal,
        "nomSucursal": nomSucursal,
        "idNumPlaza": idNumPlaza,
        "descPlaza": descPlaza,
        "sexo": sexo,
        "fecNac": fecNac,
        "telFijo": telFijo,
        "telCelular": telCelular,
        "observaciones": observaciones,
    };
}
