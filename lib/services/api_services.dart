import 'dart:convert';

import '../services/http_services.dart';
import '../models/models.dart';
import 'enpoints.dart';

class ApiService{

  final _httpService = HttpService();

  Future<Login> login() async{
    final url = Uri.http(Endpoints.baseUrl, Endpoints.loginUrl);
    Map<String, dynamic> object = {
      'usuario': 2137,
      'password': '123456',
      'latitud': '',
      'longitud': '',};
    final body = jsonEncode(object);
    String str = await _httpService.postRequest(url, body);
    Login res = loginFromJson(str);

    return res;
  }

}