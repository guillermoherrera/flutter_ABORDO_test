// To parse this JSON data, do
//
//     final prospectoRegistro = prospectoRegistroFromJson(jsonString);

import 'dart:convert';

ProspectoRegistro prospectoRegistroFromJson(String str) => ProspectoRegistro.fromJson(json.decode(str));

String prospectoRegistroToJson(ProspectoRegistro data) => json.encode(data.toJson());

class ProspectoRegistro {
    int? error;
    String? resultado;
    DataRegistro? data;

    ProspectoRegistro({
        this.error,
        this.resultado,
        this.data,
    });

    factory ProspectoRegistro.fromJson(Map<String, dynamic> json) => ProspectoRegistro(
        error: json["error"],
        resultado: json["resultado"],
        data: json["data"] != null ? DataRegistro.fromJson(json["data"]) : null,
    );

    Map<String, dynamic> toJson() => {
        "error": error,
        "resultado": resultado,
        "data": data!.toJson(),
    };
}

class DataRegistro {
    String idCliente;
    int folioRegistro;

    DataRegistro({
      required this.idCliente,
      required this.folioRegistro,
    });

    factory DataRegistro.fromJson(Map<String, dynamic> json) => DataRegistro(
        idCliente: json["id_Cliente"],
        folioRegistro: json["folio_Registro"],
    );

    Map<String, dynamic> toJson() => {
        "id_Cliente": idCliente,
        "folio_Registro": folioRegistro,
    };
}
