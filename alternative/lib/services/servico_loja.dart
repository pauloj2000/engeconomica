import 'package:alternative/infra/url_store.dart';
import 'package:alternative/model/modelo_loja.dart';
import 'package:dio/dio.dart';

class ServicoLoja {
  var dio = new Dio();

  Future<bool> adicionaLoja(String nome,
      int avaliavao, int usuarioId, String descricao, String foto) async {

    var response = await dio.post(UrlStore.urlLoja, data: {"nome": nome, "avaliavao": avaliavao,
      "usuarioId": usuarioId, "descricao": descricao, "foto": foto });

    return response.statusCode == 201;
  }

  Future<bool> alteraLoja(int id, String nome,
      int avaliavao, int usuarioId, String descricao, String foto) async {

    var response = await dio.patch(UrlStore.urlLoja, data: {"id": id, "nome": nome, "avaliavao": avaliavao,
      "usuarioId": usuarioId, "descricao": descricao, "foto": foto });

    return response.statusCode == 201;
  }

  Future<bool> excluiLoja(int id) async {

    var response = await dio.delete(UrlStore.urlLoja, queryParameters: {"id": id});

    return response.statusCode == 201;
  }

  Future<Loja> encontrePorId(int id) async {
    var response = await dio.get(UrlStore.urlLoja, queryParameters: {"id": id});

    try {
      return Loja.fromJson(response.data);
    } on Exception catch (exception) {
      return null;
    }
  }


  Future<List<Loja>> getLojas() async {
    Response response = await Dio().get(UrlStore.urlLoja);

    return LojaList.fromJson(response.data).lojaList;
  }
}
