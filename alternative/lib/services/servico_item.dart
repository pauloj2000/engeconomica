import 'package:alternative/infra/mock_db.dart';
import 'package:alternative/infra/resultado_execucao.dart';
import 'package:alternative/model/modelo_item.dart';

class ServicoItem {

  ResultadoExecucao adicionaItem(int _id, int _idLoja, String _nome,
      double _preco, String _produtoDesc, String _producaoDesc, List<Imagem> _imagem) {

    BancoDadosMock.itens.add(new Item(
        id: _id,
        idLoja: _idLoja,
        nome: _nome,
        preco: _preco,
        produtoDesc: _produtoDesc,
        producaoDesc: _producaoDesc,
        imagens: _imagem));

    return new ResultadoExecucao(true, "");
  }

  ResultadoExecucao removeItem(int _id) {
    var resultado = new ResultadoExecucao(true, "");

    if (BancoDadosMock.itens
            .contains(BancoDadosMock.itens.where((item) => item.id == _id)) ==
        false) {
      resultado.adicioneMensagemErro("Item não encontrado!");
      resultado.setResultado(false);
    } else {
      BancoDadosMock.itens.removeWhere((item) => item.id == _id);
    }

    return resultado;
  }

  ResultadoExecucao alteraItem(int _id, int _idLoja, String _nome,
      double _preco, String _produtoDesc, String _producaoDesc, List<Imagem> _imagem) {
    var resultado = new ResultadoExecucao(true, "");

    if(removeItem(_id).sucesso()){
      BancoDadosMock.itens.add(new Item(
          id: _id,
          idLoja: _idLoja,
          nome: _nome,
          preco: _preco,
          produtoDesc: _produtoDesc,
          producaoDesc: _producaoDesc,
          imagens: _imagem));
    } else {
      resultado.setResultado(false);
      resultado.adicioneMensagemErro("Não foi possível alterar.");
    }

    return resultado;
  }

  Item encontrePorId(int _id) {
    return BancoDadosMock.itens.where((item) => item.id == _id).first;
  }

  List<Item> encontreTodos() {
    return BancoDadosMock.itens;
  }
}
