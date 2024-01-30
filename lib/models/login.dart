import 'dart:convert';

Login loginFromJson(String str) => Login.fromJson(json.decode(str));

String loginToJson(Login data) => json.encode(data.toJson());

class Login {
    Data? data;
    int? error;
    String? resultado;

    Login({
        this.data,
        this.error,
        this.resultado,
    });

    factory Login.fromJson(Map<String, dynamic> json) => Login(
        data: json["data"] != null ? Data.fromJson(json["data"]) : null,
        error: json["error"],
        resultado: json["resultado"],
    );

    Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "error": error,
        "resultado": resultado,
    };
}

class Data {
    int noEmpleado;
    String nombre;
    String apPaterno;
    String apMaterno;
    bool sexo;
    String uuId;
    DateTime fechaLogin;
    String rol;
    int puesto;
    String? token;

    Data({
        required this.noEmpleado,
        required this.nombre,
        required this.apPaterno,
        required this.apMaterno,
        required this.sexo,
        required this.uuId,
        required this.fechaLogin,
        required this.rol,
        required this.puesto,
        this.token,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        noEmpleado: json["no_Empleado"],
        nombre: json["nombre"],
        apPaterno: json["ap_Paterno"],
        apMaterno: json["ap_Materno"],
        sexo: json["sexo"],
        uuId: json["uuId"],
        fechaLogin: DateTime.parse(json["fechaLogin"]),
        rol: json["rol"],
        puesto: json["puesto"],
        token: json["token"],
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
        "token": token,
    };
}