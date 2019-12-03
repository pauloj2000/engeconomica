import 'package:alternative/infra/http_client.dart';
import 'package:alternative/infra/type_request.dart';
import 'package:alternative/infra/url_store.dart';
import 'package:alternative/model/modelo_item.dart';

class ServicoItem {

  static List<Item> itens = new List<Item>();

  adicionaItem(int _idLoja, String _nome,
      double _preco, String _produtoDesc, String _producaoDesc) {

    var item = new Item(
        idLoja: _idLoja,
        nome: _nome,
        preco: _preco,
        produtoDesc: _produtoDesc,
        producaoDesc: _producaoDesc);

    final String url = UrlStore.urlItem;

    MyHttpClient httpClient = new MyHttpClient(
        url: url,
        type: TypeRequest.POST,
        body: item.toJson(),
        onSucess: _onSucess,
        onFail: _onFail);

    httpClient.executar();
    print(url);
    print(httpClient.body);
  }

  _onSucess(var response, var headers) {
    print(" -- SUCESSO! --");
  }
  _onFail(var response) {
    print(" --- ERRO --- ");
    print(response);
  }

  removeItem(int _id) {

    final String url = UrlStore.urlItem + "?id=eq." + _id.toString();

    MyHttpClient httpClient = new MyHttpClient(
        url: url,
        type: TypeRequest.DELETE,
        onSucess: _onSucess,
        onFail: _onFail);

    httpClient.executar();
    print(url);
    print(httpClient.body);
  }

  getItens() {
    final String url = UrlStore.urlItem;

    MyHttpClient httpClient = new MyHttpClient(
        url: url,
        type: TypeRequest.GET,
        onSucess: _onSucessGetItens,
        onFail: _onFail);

    httpClient.executar();
    print(url);
    print(httpClient.body);
  }

  _onSucessGetItens(var response, var headers) {
    ItemList item = new ItemList.fromJson(response);
    itens = item.itemList;
    print(" -- SUCESSO! --");
  }

  Item encontrePorId(BigInt _id) {
    return itens.where((item) => item.id == _id).first;
  }

  List<Item> encontreTodos() {
    return itens;
  }
}
