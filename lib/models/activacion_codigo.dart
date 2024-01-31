// To parse this JSON data, do
//
//     final activacionCodigo = activacionCodigoFromJson(jsonString);

import 'dart:convert';

ActivacionCodigo activacionCodigoFromJson(String str) => ActivacionCodigo.fromJson(json.decode(str));

String activacionCodigoToJson(ActivacionCodigo data) => json.encode(data.toJson());

class ActivacionCodigo {
    DataActivacionCodigo? data;
    int? error;
    String? resultado;

    ActivacionCodigo({
        this.data,
        this.error,
        this.resultado,
    });

    factory ActivacionCodigo.fromJson(Map<String, dynamic> json) => ActivacionCodigo(
        data: json["data"] != null ? DataActivacionCodigo.fromJson(json["data"]) : null,
        error: json["error"],
        resultado: json["resultado"],
    );

    Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "error": error,
        "resultado": resultado,
    };
}

class DataActivacionCodigo {
    String? codigo;

    DataActivacionCodigo({
        this.codigo,
    });

    factory DataActivacionCodigo.fromJson(Map<String, dynamic> json) => DataActivacionCodigo(
        codigo: json["codigo"],
    );

    Map<String, dynamic> toJson() => {
        "codigo": codigo,
    };
}
