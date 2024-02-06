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

    DataProspectoObtenerPerfil({
      required this.fechaRegistro,
      required this.nombre,
      required this.descClienteStat,
      required this.folioRegistro,
      this.color,
    });

    factory DataProspectoObtenerPerfil.fromJson(Map<String, dynamic> json) => DataProspectoObtenerPerfil(
        fechaRegistro: DateTime.parse(json["fecha_Registro"]),
        nombre: json["nombre"],
        descClienteStat: json["desc_ClienteStat"],
        folioRegistro: json["folio_Registro"],
        color: json["color"],
    );

    Map<String, dynamic> toJson() => {
        "fecha_Registro": fechaRegistro.toIso8601String(),
        "nombre": nombre,
        "desc_ClienteStat": descClienteStat,
        "color": color,
    };
}
