// To parse this JSON data, do
//
//     final prospectosObtenerLista = prospectosObtenerListaFromJson(jsonString);

import 'dart:convert';

ProspectosObtenerLista prospectosObtenerListaFromJson(String str) => ProspectosObtenerLista.fromJson(json.decode(str));

String prospectosObtenerListaToJson(ProspectosObtenerLista data) => json.encode(data.toJson());

class ProspectosObtenerLista {
    List<DatumProspectos>? data;
    int? error;
    String? resultado;

    ProspectosObtenerLista({
        this.data,
        this.error,
        this.resultado,
    });

    factory ProspectosObtenerLista.fromJson(Map<String, dynamic> json) => ProspectosObtenerLista(
        data: json["data"] != null ?   List<DatumProspectos>.from(json["data"].map((x) => DatumProspectos.fromJson(x))) : null,
        error: json["error"],
        resultado: json["resultado"],
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "error": error,
        "resultado": resultado,
    };
}

class DatumProspectos {
    DateTime fechaRegistro;
    String nombre;
    String descClienteStat;
    int folioRegistro;

    DatumProspectos({
      required this.fechaRegistro,
      required this.nombre,
      required this.descClienteStat,
      required this.folioRegistro,
    });

    factory DatumProspectos.fromJson(Map<String, dynamic> json) => DatumProspectos(
        fechaRegistro: DateTime.parse(json["fecha_Registro"]),
        nombre: json["nombre"],
        descClienteStat: json["desc_ClienteStat"],
        folioRegistro: json["folio_Registro"],
    );

    Map<String, dynamic> toJson() => {
        "fecha_Registro": fechaRegistro.toIso8601String(),
        "nombre": nombre,
        "desc_ClienteStat": descClienteStat,
        "folio_Registro": folioRegistro,
    };
}
