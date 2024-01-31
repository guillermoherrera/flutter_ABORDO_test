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

}