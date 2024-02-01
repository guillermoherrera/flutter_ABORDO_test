import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../services/http_services.dart';
import '../models/models.dart';
import 'api_enpoints.dart';

class ApiService{

  final _storage = const FlutterSecureStorage();
  final _httpService = HttpService();

  Future<Login> login(int user, String pass) async{
    final url = Uri.http(Endpoints.baseUrl, Endpoints.loginUrl);
    Map<String, dynamic> object = {
      'usuario': user,
      'password': pass,
      'latitud': '',
      'longitud': '',};
    final body = jsonEncode(object);
    String str = await _httpService.postRequest(url, body);
    Login res = loginFromJson(str);
    if(res.error == 0) await _storage.write(key: 'token', value: res.data?.token);
    return res;
  }

  Future<bool> logout()async{
    try {
      //borrar Blocs
      await _storage.delete(key: 'token');
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<ActivacionCodigo> activacionCodigo(int user, String telefono) async{
    final url = Uri.http(Endpoints.baseUrl, Endpoints.activacionCodigoUrl);
    Map<String, dynamic> object = {
      'usuario': user,
      'telefono': telefono};
    final body = jsonEncode(object);
    String str = await _httpService.postRequest(url, body);
    ActivacionCodigo res = activacionCodigoFromJson(str);
    
    return res;
  }

  Future<Login> activacion(int user, String codigo, String password) async{
    final url = Uri.http(Endpoints.baseUrl, Endpoints.activacionUrl);
    Map<String, dynamic> object = {
      'usuario': user,
      'codigo': codigo,
      'password': password,
      'latitud': '',
      'longitud': ''};
    final body = jsonEncode(object);
    String str = await _httpService.postRequest(url, body);
    Login res = loginFromJson(str);
    if(res.error == 0) await _storage.write(key: 'token', value: res.data?.token);
    
    return res;
  }

  Future<ActivacionCodigo> recuperacionCodigo(int user, String telefono) async{
    final url = Uri.http(Endpoints.baseUrl, Endpoints.recuperacionCodigoUrl);
    Map<String, dynamic> object = {
      'usuario': user,
      'telefono': telefono};
    final body = jsonEncode(object);
    String str = await _httpService.postRequest(url, body);
    ActivacionCodigo res = activacionCodigoFromJson(str);
    
    return res;
  }

  Future<Login> recuperacion(int user, String codigo, String password) async{
    final url = Uri.http(Endpoints.baseUrl, Endpoints.recuperacionUrl);
    Map<String, dynamic> object = {
      'usuario': user,
      'codigo': codigo,
      'password': password,
      'latitud': '',
      'longitud': ''};
    final body = jsonEncode(object);
    String str = await _httpService.postRequest(url, body);
    Login res = loginFromJson(str);
    if(res.error == 0) await _storage.write(key: 'token', value: res.data?.token);
    
    return res;
  }

  Future<InfoUsuario> infoUsuario() async{
    final url = Uri.http(Endpoints.baseUrl, Endpoints.infoUsuarioUrl);
    String str = await _httpService.getRequest(url);
    InfoUsuario res = infoUsuarioFromJson(str);
    
    return res;
  }

  Future<LogUsuario> logUsuario() async{
    final url = Uri.http(Endpoints.baseUrl, Endpoints.logUsuarioUrl);
    String str = await _httpService.getRequest(url);
    LogUsuario res = logUsuarioFromJson(str);
    
    return res;
  }

  Future<ProspectosObtenerLista> prospectosObtenerLista() async{
    final url = Uri.http(Endpoints.baseUrl, Endpoints.prospectosObtenerListaUrl);
    String str = await _httpService.getRequest(url);
    ProspectosObtenerLista res = prospectosObtenerListaFromJson(str);
    
    return res;
  }

  Future<ProspectoRegistro> prospectoRegistro(Prospecto prospecto, int plaza, int sucursal) async{
    final url = Uri.http(Endpoints.baseUrl, Endpoints.prospectoRegistroUrl);
    Map<String, dynamic> object = {
      "pId_Num_Plaza": plaza,
      "pId_Num_Sucursal": sucursal,
      "pNombre": prospecto.nombre,
      "pAp_Paterno": prospecto.primerApellido,
      "pAp_Materno": prospecto.segundoApellido,
      "pSexo": prospecto.sexo,
      "pFec_Nac": prospecto.fechaNacimiento,
      "pDomicilio": prospecto.calle,
      "pNum_Ext": prospecto.noExterior,
      "pNum_Int": prospecto.noInterior,
      "pCP": int.parse(prospecto.cp ?? '0'),
      "pc_Codigo": prospecto.colonia,
      "pTel_Fijo": prospecto.telFijo,
      "pTel_Celular": prospecto.telCelular,
      "pObservaciones": prospecto.observacion,
      "colonia": prospecto.colonia,};
    final body = jsonEncode(object);
    String str = await _httpService.postRequest(url, body);
    ProspectoRegistro res = prospectoRegistroFromJson(str);
    
    return res;
  }

}