import 'package:alternative/infra/url_store.dart';
import 'package:alternative/model/modelo_loja_favorita.dart';
import 'package:alternative/singleton/singleton_usuario.dart';
import 'package:dio/dio.dart';

class ServicoLojasFavoritas {
  var dio = new Dio();

  Future<bool> adicioneItem(int lojaId) async {
    var response = await dio.post(UrlStore.urlLojaFavorita, data: {
      "lojaId": lojaId,
      "usuarioId": SingletonUsuario.instance.usuarioLogado.id
    });

    return response.statusCode == 201;
  }

  Future<bool> excluiItem(int usuarioId, int lojaId) async {
    var response = await dio.delete(UrlStore.urlLojaFavorita,
        queryParameters: {"usuarioId": usuarioId, "lojaId": lojaId});

    return response.statusCode == 201;
  }

  Future<LojaFavorita> encontrePorIdLoja(String id) async {
    var response = await dio.get(UrlStore.urlLojaFavorita + "?lojaId=eq.$id");

    return LojaFavorita.fromJson(response.data);
  }

  Future<LojaFavorita> encontrePorIdUsuario(String id) async {
    var response =
        await dio.get(UrlStore.urlLojaFavorita + "?usuarioId=eq.$id");

    return LojaFavorita.fromJson(response.data);
  }

  Future<List<LojaFavorita>> getItens() async {
    Response response = await Dio().get(UrlStore.urlLojaFavorita);

    return LojaFavoritaList.fromJson(response.data).lojaList;
  }
}
