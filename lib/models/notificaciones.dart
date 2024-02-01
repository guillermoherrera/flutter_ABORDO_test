// To parse this JSON data, do
//
//     final notificaciones = notificacionesFromJson(jsonString);

import 'dart:convert';

Notificaciones notificacionesFromJson(String str) => Notificaciones.fromJson(json.decode(str));

String notificacionesToJson(Notificaciones data) => json.encode(data.toJson());

class Notificaciones {
    int? error;
    String? resultado;
    List<DatumNotificaciones>? data;

    Notificaciones({
        this.error,
        this.resultado,
        this.data,
    });

    factory Notificaciones.fromJson(Map<String, dynamic> json) => Notificaciones(
        error: json["error"],
        resultado: json["resultado"],
        data: json["data"] != null ? List<DatumNotificaciones>.from(json["data"].map((x) => DatumNotificaciones.fromJson(x))) : null,
    );

    Map<String, dynamic> toJson() => {
        "error": error,
        "resultado": resultado,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class DatumNotificaciones {
    String notificacion;
    DateTime fecha;
    String modulo;

    DatumNotificaciones({
      required this.notificacion,
      required this.fecha,
      required this.modulo,
    });

    factory DatumNotificaciones.fromJson(Map<String, dynamic> json) => DatumNotificaciones(
        notificacion: json["notificacion"],
        fecha: DateTime.parse(json["fecha"]),
        modulo: json["modulo"],
    );

    Map<String, dynamic> toJson() => {
        "notificacion": notificacion,
        "fecha": fecha.toIso8601String(),
        "modulo": modulo,
    };
}
