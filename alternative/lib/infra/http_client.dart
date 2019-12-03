import 'dart:convert' as convert;
import 'package:alternative/infra/type_request.dart';
import 'package:http/io_client.dart';
import 'dart:io';

class MyHttpClient{

  String url;
  Map<String, String> header;
  Map<dynamic, dynamic> body;
  var onSucess;
  var onFail;
  Uri uri;
  TypeRequest type;
  File file;

  MyHttpClient({
    this.onFail,
    this.onSucess,
    this.body,
    this.type,
    this.header,
    this.url,
    this.file,
    this.uri
  });

  executar(){

    switch(type){
      case TypeRequest.POST:
        post();
        break;
      case TypeRequest.GET:
        if(header == null){
          header = Map<String, String>();
          dynamic content = 'Content-type';
          dynamic application = 'application/json';
          header[content] = application;
        }
        get();
        break;
      default:
        break;
    }
  }

  post() async{
    final ioc = new HttpClient();
    ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    var _body = convert.json.encode(body);
    var response = await http.post(url, headers: header == null ? {'Content-Type': 'application/json',} : header, body: _body);
    print("Request:");
    print(url);
    print(_body);
    print("Response:");
    print(response.statusCode);
    print(response.body);
    if (response.statusCode != 200 &&  response.statusCode != 201 ) {
      if(response.statusCode == 400){
        onFail('400 - Erro!', 'Por favor, informe as credenciais.');
      }else if(response.statusCode == 401){
        onFail('401 - Erro!', 'Usuário ou Senha inválidos! \nPor favor, tente novamente.');
      }else if(response.statusCode == 403){
        onFail('403 - Sem Permissão!', 'Usuário não tem permissão para acessar esta área!');
      }else if(response.statusCode == 404){
        onFail('404 - Erro!', 'Recuso não encontrado! \nPor favor, tente novamente.');
      }else{
        onFail('500 - Erro interno!', 'Por favor, tente novamente em alguns minutos.');
      }
      //onFail(response);
    } else {
      if(!response.body.isEmpty){
        final responseJson = convert.jsonDecode(response.body);
        //sucesso quando loga usuario
        onSucess(responseJson, response.headers);
      }else{
        //sucesso quando loga sistema
        onSucess(response.headers);
      }
    }
  }

  get() async{
    try{
      final ioc = new HttpClient();
      ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      final http = new IOClient(ioc);
      var response = await http.get(url, headers: header).timeout(new Duration(seconds: 30));
      if (response.statusCode != 200 &&  response.statusCode != 201 ) {
        onFail(response);
      } else {
        final responseJson = convert.jsonDecode(response.body);
        onSucess(responseJson, response.headers);
      }
    } catch(e){
      onFail(e);
    }

  }
}