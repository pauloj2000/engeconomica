import 'package:alternative/infra/url_store.dart';
import 'package:alternative/model/modelo_item.dart';
import 'package:dio/dio.dart';

class ServicoItem {

  var dio = new Dio();

  Future<bool> adicioneItem(String nome,
      double preco, int idLoja) async {

    var response = await dio.post(UrlStore.urlLoja, data: {"nome": nome, "preco": preco,
      "idLoja": idLoja });

    return response.statusCode == 201;
  }

  Future<bool> altereItem(int id,String nome,
      double preco, int idLoja) async {

    var response = await dio.patch(UrlStore.urlLoja, data: {"id": id, "nome": nome, "preco": preco,
      "idLoja": idLoja });

    return response.statusCode == 201;
  }

  Future<bool> excluiItem(int id) async {
    var response = await dio.delete(UrlStore.urlLoja, queryParameters: {"id": id});

    return response.statusCode == 201;
  }

  Future<Item> encontrePorId(int id) async {
    var response = await dio.get(UrlStore.urlLoja, queryParameters: {"id": id});

    return Item.fromJson(response.data);
  }

  Future<List<Item>> getItens() async {
    Response response = await Dio().get(UrlStore.urlLoja);

    return ItemList.fromJson(response.data).itemList;
  }
}
