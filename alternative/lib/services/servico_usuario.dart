import 'package:alternative/infra/http_client.dart';
import 'package:alternative/infra/type_request.dart';
import 'package:alternative/infra/url_store.dart';
import 'package:alternative/model/modelo_usuario.dart';

class ServicoUsuario {

  static List<Usuario> usuarios = new List<Usuario>();

  void adicionaUsuario(String _nome, String _email,
      String _senha) {

    final String url = UrlStore.urlUsuario;

    var usuario = new Usuario(
        nome: _nome,
        email: _email,
        senha: _senha);

    MyHttpClient httpClient = new MyHttpClient(
        url: url,
        type: TypeRequest.POST,
        body: usuario.toJson(),
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

  getUsuarios() {
    final String url = UrlStore.urlUsuario;

    MyHttpClient httpClient = new MyHttpClient(
        url: url,
        type: TypeRequest.GET,
        onSucess: _onSucessGetUsuarios,
        onFail: _onFail);

    httpClient.executar();
    print(url);
    print(httpClient.body);
  }

  _onSucessGetUsuarios(var response, var headers) {
    UsuarioList user = new UsuarioList.fromJson(response);
    usuarios = user.usuarioList;
    print(" -- SUCESSO! --");
  }


  Usuario encontrePorId(int _id) {
    return usuarios.where((user) => user.id == _id).first;
  }

}
