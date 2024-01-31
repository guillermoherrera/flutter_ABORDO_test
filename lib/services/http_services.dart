import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
class HttpService{

  final _storage = const FlutterSecureStorage();

  Future<String> getDeviceUniqueId() async {
    var deviceIdentifier = '';
    var deviceInfo = DeviceInfoPlugin();
    
    if (Platform.isAndroid) {
      var androidInfo = await deviceInfo.androidInfo;
      deviceIdentifier = androidInfo.id;
    } else if (Platform.isIOS) {
      var iosInfo = await deviceInfo.iosInfo;
      deviceIdentifier = iosInfo.identifierForVendor!;
    } else {
      deviceIdentifier = 'unknown';
    }
    return deviceIdentifier;
  }
  
  Future<String> postRequest(url, body) async{
    String respuesta = '';
    String? token = await _storage.read(key: 'token');
    String uuid = await getDeviceUniqueId();
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
      'UUId': uuid
    };

    await http.post(url, headers: headers, body: body).then((value){
      respuesta = value.body;
    }).catchError((e){
      respuesta = "{\"data\": null, \"error\": 1, \"resultado\": \"${e.toString()}\"}";
    }).timeout(const Duration(seconds: 60), onTimeout: (){
      respuesta = "{\"data\": null, \"error\": 1, \"resultado\": \"TIEMPO DE ESPERA AGOTADO.\\nPOR FAVOR REVISA TU CONEXIÓN.\"}";
    });

    return respuesta;
  }

  Future<String> getRequest(url) async{
    String respuesta = '';
    String? token = await _storage.read(key: 'token');
    String uuid = await getDeviceUniqueId();
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
      'UUId': uuid
    };

    await http.get(url, headers: headers).then((value){
      respuesta = value.body;
    }).catchError((e){
      respuesta = "{\"data\": null, \"error\": 1, \"resultado\": \"${e.toString()}\"}";
    }).timeout(const Duration(seconds: 60), onTimeout: (){
      respuesta = "{\"data\": null, \"error\": 1, \"resultado\": \"TIEMPO DE ESPERA AGOTADO.\\nPOR FAVOR REVISA TU CONEXIÓN.\"}";
    });

    return respuesta;
  }

}