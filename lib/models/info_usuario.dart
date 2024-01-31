// To parse this JSON data, do
//
//     final InfoUsuario = InfoUsuarioFromJson(jsonString);

import 'dart:convert';

InfoUsuario infoUsuarioFromJson(String str) => InfoUsuario.fromJson(json.decode(str));

String infoUsuarioToJson(InfoUsuario data) => json.encode(data.toJson());

class InfoUsuario {
    DataInfoUsuario? data;
    int? error;
    String? resultado;

    InfoUsuario({
        this.data,
        this.error,
        this.resultado,
    });

    factory InfoUsuario.fromJson(Map<String, dynamic> json) => InfoUsuario(
        data: json["data"] != null ?  DataInfoUsuario.fromJson(json["data"]) : null,
        error: json["error"],
        resultado: json["resultado"],
    );

    Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "error": error,
        "resultado": resultado,
    };
}

class DataInfoUsuario {
    int noEmpleado;
    String nombre;
    String apPaterno;
    String apMaterno;
    bool sexo;
    String uuId;
    DateTime fechaLogin;
    String rol;
    int puesto;
    int idNumSucursal;
    String sucursal;
    int idNumPlaza;
    String plaza;
    String versionAndroid;
    String versionIos;
    bool prospeccion;
    bool verificacion;
    bool cobranza;
    bool claridadPago;
    bool capacitacion;

    DataInfoUsuario({
      required this.noEmpleado,
      required this.nombre,
      required this.apPaterno,
      required this.apMaterno,
      required this.sexo,
      required this.uuId,
      required this.fechaLogin,
      required this.rol,
      required this.puesto,
      required this.idNumSucursal,
      required this.sucursal,
      required this.idNumPlaza,
      required this.plaza,
      required this.versionAndroid,
      required this.versionIos,
      required this.prospeccion,
      required this.verificacion,
      required this.cobranza,
      required this.claridadPago,
      required this.capacitacion,
    });

    factory DataInfoUsuario.fromJson(Map<String, dynamic> json) => DataInfoUsuario(
        noEmpleado: json["no_Empleado"],
        nombre: json["nombre"],
        apPaterno: json["ap_Paterno"],
        apMaterno: json["ap_Materno"],
        sexo: json["sexo"],
        uuId: json["uuId"],
        fechaLogin: DateTime.parse(json["fechaLogin"]),
        rol: json["rol"],
        puesto: json["puesto"],
        idNumSucursal: json["id_Num_Sucursal"],
        sucursal: json["sucursal"],
        idNumPlaza: json["id_Num_Plaza"],
        plaza: json["plaza"],
        versionAndroid: json["version_Android"],
        versionIos: json["version_IOS"],
        prospeccion: json["prospeccion"],
        verificacion: json["verificacion"],
        cobranza: json["cobranza"],
        claridadPago: json["claridad_Pago"],
        capacitacion: json["capacitacion"],
    );

    Map<String, dynamic> toJson() => {
        "no_Empleado": noEmpleado,
        "nombre": nombre,
        "ap_Paterno": apPaterno,
        "ap_Materno": apMaterno,
        "sexo": sexo,
        "uuId": uuId,
        "fechaLogin": fechaLogin.toIso8601String(),
        "rol": rol,
        "puesto": puesto,
        "id_Num_Sucursal": idNumSucursal,
        "sucursal": sucursal,
        "id_Num_Plaza": idNumPlaza,
        "plaza": plaza,
        "version_Android": versionAndroid,
        "version_IOS": versionIos,
        "prospeccion": prospeccion,
        "verificacion": verificacion,
        "cobranza": cobranza,
        "claridad_Pago": claridadPago,
        "capacitacion": capacitacion,
    };
}
