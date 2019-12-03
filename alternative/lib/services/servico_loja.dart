import 'package:alternative/infra/http_client.dart';
import 'package:alternative/infra/resultado_execucao.dart';
import 'package:alternative/infra/type_request.dart';
import 'package:alternative/infra/url_store.dart';
import 'package:alternative/model/modelo_loja.dart';

class ServicoLoja {

  static List<Loja> lojas = new List<Loja>();

  ResultadoExecucao adicionaLoja(String _nome,
      int _avaliacao, int _idUsuario, String _descricao, String _foto) {

    var loja = new Loja(
        nome: _nome,
        avaliacao: _avaliacao,
        idUsuario:  _idUsuario,
        descricao: _descricao,
        foto: _foto,
    );

    final String url = UrlStore.urlLoja;

    MyHttpClient httpClient = new MyHttpClient(
        url: url,
        type: TypeRequest.POST,
        body: loja.toJson(),
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

  getLojas() {
    final String url = UrlStore.urlLoja;

    MyHttpClient httpClient = new MyHttpClient(
        url: url,
        type: TypeRequest.GET,
        onSucess: _onSucessGetLojas,
        onFail: _onFail);

    httpClient.executar();
    print(url);
    print(httpClient.body);
  }

  _onSucessGetLojas(var response, var headers) {
    LojaList loja = new LojaList.fromJson(response);
    lojas = loja.lojaList;
    print(" -- SUCESSO! --");
  }

  Loja encontrePorId(int _id) {
    return lojas.where((loja) => loja.id == _id).first;
  }

  List<Loja> encontreTodos() {
    return lojas;
  }
}
