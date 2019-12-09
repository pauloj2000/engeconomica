import 'package:alternative/infra/url_store.dart';
import 'package:alternative/model/modelo_usuario.dart';
import 'package:dio/dio.dart';

class ServicoUsuario {

  var dio = new Dio();

  Future<bool> adicionaUsuario(String _nome, String _email,
      String _senha) async {

    var response = await dio.post(UrlStore.urlUsuario, data: {"nome": _nome, "email": _email,
    "senha": _senha});

    return response.statusCode == 201;
  }

  Future<bool> alteraUsuario(int id, String _nome, String _email,
      String _senha) async {

    var response = await dio.patch(UrlStore.urlUsuario, data: {"id": id, "nome": _nome, "email": _email,
      "senha": _senha});

    return response.statusCode == 201;
  }

  Future<bool> excluiUsuario(int id) async {

    var response = await dio.delete(UrlStore.urlUsuario, queryParameters: {"id": id});

    return response.statusCode == 201;
  }


  Future<Usuario> encontrePorId(int id) async {
    var response = await dio.get(UrlStore.urlUsuario+ "?id=eq.$id");

    return Usuario.fromJson(response.data);
  }

  Future<Usuario> encontrePorEmail(String email) async {
    var response = await dio.get(UrlStore.urlUsuario, queryParameters: {"email": email});

    return Usuario.fromJson(response.data);
  }

  Future<List<Usuario>> getUsuarios() async {
      Response response = await Dio().get(UrlStore.urlUsuario);

      return UsuarioList.fromJson(response.data).usuarioList;
  }
}
