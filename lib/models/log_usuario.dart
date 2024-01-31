// To parse this JSON data, do
//
//     final logUsuario = logUsuarioFromJson(jsonString);

import 'dart:convert';

LogUsuario logUsuarioFromJson(String str) => LogUsuario.fromJson(json.decode(str));

String logUsuarioToJson(LogUsuario data) => json.encode(data.toJson());

class LogUsuario {
    List<Datum>? data;
    int? error;
    String? resultado;

    LogUsuario({
        this.data,
        this.error,
        this.resultado,
    });

    factory LogUsuario.fromJson(Map<String, dynamic> json) => LogUsuario(
        data: json["data"] != null ?  List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))) : null,
        error: json["error"],
        resultado: json["resultado"],
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "error": error,
        "resultado": resultado,
    };
}

class Datum {
    String logDescripcion;
    DateTime fecha;
    String? modulo;

    Datum({
      required this.logDescripcion,
      required this.fecha,
      this.modulo,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        logDescripcion: json["log_Descripcion"],
        fecha: DateTime.parse(json["fecha"]),
        modulo: json["modulo"],
    );

    Map<String, dynamic> toJson() => {
        "log_Descripcion": logDescripcion,
        "fecha": fecha.toIso8601String(),
        "modulo": modulo,
    };
}
