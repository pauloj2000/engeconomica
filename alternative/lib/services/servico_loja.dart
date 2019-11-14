import 'package:alternative/infra/mock_db.dart';
import 'package:alternative/infra/resultado_execucao.dart';
import 'package:alternative/model/modelo_loja.dart';

class ServicoLoja {

  ResultadoExecucao adicionaLoja(int _id, String _nome, double _caixa,
      double _valorTotalRecebido, int _avaliacao, int _idUsuario, String _descricao, String _foto) {
    BancoDadosMock.lojas.add(new Loja(
      id: _id,
      nome: _nome,
      caixa: _caixa,
      valorTotalRecebido: _valorTotalRecebido,
      avaliacao: _avaliacao,
      idUsuario:  _idUsuario,
      descricao: _descricao,
      foto: _foto,
    ));

    return new ResultadoExecucao(true, "");
  }

  ResultadoExecucao removeLoja(int _id) {
    var resultado = new ResultadoExecucao(true, "");

    if (BancoDadosMock.lojas
            .contains(BancoDadosMock.lojas.where((loja) => loja.id == _id)) ==
        false) {
      resultado.adicioneMensagemErro("Loja não encontrada!");
      resultado.setResultado(false);
    } else {
      BancoDadosMock.lojas.removeWhere((loja) => loja.id == _id);
    }

    return resultado;
  }

  ResultadoExecucao alteraLoja(int _id, String _nome, double _caixa,
      double _valorTotalRecebido, int _avaliacao, int _idUsuario, String _descricao, String _foto) {
    removeLoja(_id);

    var resultado = new ResultadoExecucao(true, "");

    if(removeLoja(_id).sucesso()){
      BancoDadosMock.lojas.add(new Loja(
        id: _id,
        nome: _nome,
        caixa: _caixa,
        valorTotalRecebido: _valorTotalRecebido,
        avaliacao: _avaliacao,
        idUsuario: _idUsuario,
        descricao: _descricao,
        foto: _foto,
      ));
    } else {
      resultado.setResultado(false);
      resultado.adicioneMensagemErro("Não foi possível alterar.");
    }

    return resultado;
  }

  Loja encontrePorId(int _id) {
    return BancoDadosMock.lojas.where((loja) => loja.id == _id).first;
  }

  List<Loja> encontreTodos() {
    return BancoDadosMock.lojas;
  }
}
