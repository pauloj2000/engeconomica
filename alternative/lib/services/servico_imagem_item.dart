import 'package:alternative/infra/url_store.dart';
import 'package:alternative/model/modelo_imagem_item.dart';
import 'package:dio/dio.dart';

class ServicoImagemItem {
  var dio = new Dio();

  Future<bool> adicioneImagemItem(int itemId, String content) async {
    var response = await dio.post(UrlStore.urlImagemItem,
        data: {"itemId": itemId, "content": content});

    return response.statusCode == 201;
  }

  Future<bool> excluaImagemItem(int id) async {
    var response =
        await dio.delete(UrlStore.urlImagemItem, queryParameters: {"id": id});

    return response.statusCode == 201;
  }

  Future<ImagemItem> encontrePorItem(int itemId) async {
    var response = await dio
        .get(UrlStore.urlImagemItem, queryParameters: {"itemId": itemId});

    return ImagemItem.fromJson(response.data);
  }

  Future<List<ImagemItem>> getImagensItens() async {
    Response response = await Dio().get(UrlStore.urlImagemItem);

    return ImagemItemList.fromJson(response.data).imagemItemList;
  }
}
