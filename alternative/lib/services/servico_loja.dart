import 'package:alternative/infra/url_store.dart';
import 'package:alternative/model/modelo_loja.dart';
import 'package:alternative/singleton/singleton_usuario.dart';
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

  Future<Loja> encontrePorUsuarioId() async {
    var id = SingletonUsuario.instance.usuarioLogado.id;

    var response = await dio.get(UrlStore.urlLoja + "?usuarioId=eq.$id");

    return Loja.fromJson(response.data[0]);
  }

  Future<Loja> encontreLojaPorId(String id) async {
    var response = await dio.get(UrlStore.urlLoja + "?id=eq.$id");

    return Loja.fromJson(response.data[0]);
  }

  Future<bool> existeLojaParaUsuario() async {
    var id = SingletonUsuario.instance.usuarioLogado.id;

    var response = await dio.get(UrlStore.urlLoja + "?usuarioId=eq.$id");

    if(response.statusCode == 200){
      var gambiarra = response.data.toString();

      if(gambiarra == "[]"){
        return false;
      }
      var loja = Loja.fromJson(response.data[0]);

      return loja != null;
    } else {
      return false;
    }
  }

  Future<List<Loja>> getLojas() async {
    Response response = await Dio().get(UrlStore.urlLoja);

    return LojaList.fromJson(response.data).lojaList;
  }
}
