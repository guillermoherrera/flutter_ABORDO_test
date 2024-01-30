import 'dart:convert';

import '../services/http_services.dart';
import '../models/models.dart';
import 'api_enpoints.dart';

class ApiService{

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

    return res;
  }

}