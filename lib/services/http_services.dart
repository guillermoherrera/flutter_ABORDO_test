import 'package:http/http.dart' as http;
class HttpService{
  
  Future<String> postRequest(url, body) async{
    String respuesta = '';
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer',
      'UUId': 'testx'
    };

    await http.post(url, headers: headers, body: body).then((value){
      respuesta = value.body;
    }).catchError((e){
      respuesta = "{\"data\": null, \"error\": 1, \"resultado\": \"${e.toString()}\"}";
    }).timeout(const Duration(seconds: 60), onTimeout: (){
      respuesta = "{\"data\": null, \"error\": 1, \"resultado\": \"REQUEST ERROR: TIEMPO DE ESPERA AGOTADO PARA LA SOLICITUD\"}";
    });

    return respuesta;
  }

}