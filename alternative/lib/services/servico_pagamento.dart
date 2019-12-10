import 'package:alternative/infra/url_store.dart';
import 'package:alternative/model/modelo_pagamento.dart';
import 'package:alternative/singleton/singleton_usuario.dart';
import 'package:dio/dio.dart';

class ServicoPagamento {

  var dio = new Dio();

  Future<bool> adicionePagamento(double valor) async {

    var response = await dio.post(UrlStore.urlPagamento, data: {"dataPag": "10/12/2019", "valor": valor,
      "usuarioId": SingletonUsuario.instance.usuarioLogado.id });

    return response.statusCode == 201;
  }

  Future<bool> alterePagamento(int id, String dataPag,
      double valor, int usuarioId) async {

    var response = await dio.patch(UrlStore.urlPagamento, data: {"id": id, "dataPag": dataPag,"valor": valor,
      "usuarioId": usuarioId });

    return response.statusCode == 201;
  }

  Future<bool> excluiPagamento(int id) async {
    var response = await dio.delete(UrlStore.urlPagamento + "?id=eq.$id");

    return response.statusCode == 201;
  }

  Future<Pagamento> encontrePorId(int id) async {
    var response = await dio.get(UrlStore.urlPagamento + "?id=eq.$id");

    return Pagamento.fromJson(response.data);
  }

  Future<List<Pagamento>> getPagamentos() async {
    Response response = await Dio().get(UrlStore.urlPagamento);

    return PagamentoList.fromJson(response.data).pagamentoList;
  }
}
