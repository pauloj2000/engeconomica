import 'package:alternative/infra/mock_db.dart';
import 'package:alternative/infra/resultado_execucao.dart';
import 'package:alternative/model/modelo_usuario.dart';

class ServicoUsuario {
  ResultadoExecucao adicionaUsuario(int _id, String _nome, String _email,
      String _senha, String _dataCriacao, List<Pagamento> _pagamentos, int idLoja) {

    BancoDadosMock.usuarios.add(new Usuario(
        id: _id,
        nome: _nome,
        email: _email,
        senha: _senha,
        dataCriacao: _dataCriacao,
        pagamentos: _pagamentos));

    return new ResultadoExecucao(true, "");
  }

  ResultadoExecucao removeUsuario(int _id) {
    var resultado = new ResultadoExecucao(true, "");

    if (BancoDadosMock.usuarios
            .contains(BancoDadosMock.usuarios.where((usuario) => usuario.id == _id)) ==
        false) {
      resultado.adicioneMensagemErro("Usuário não encontrado!");
      resultado.setResultado(false);
    } else {
      BancoDadosMock.usuarios.removeWhere((usuario) => usuario.id == _id);
    }

    return resultado;
  }

  ResultadoExecucao alteraUsuario(int _id, String _nome, String _email,
      String _senha, String _dataCriacao, List<Pagamento> _pagamentos, int idLoja) {

    var resultado = new ResultadoExecucao(true, "");

    if(removeUsuario(_id).sucesso()){
      BancoDadosMock.usuarios.add(new Usuario(
          id: _id,
          nome: _nome,
          email: _email,
          senha: _senha,
          dataCriacao: _dataCriacao,
          pagamentos: _pagamentos));
    } else {
      resultado.setResultado(false);
      resultado.adicioneMensagemErro("Não foi possível alterar.");
    }

    return resultado;
  }

  Usuario encontrePorId(int _id) {
    return BancoDadosMock.usuarios.where((user) => user.id == _id).first;
  }

  List<Usuario> encontreTodos() {
    return BancoDadosMock.usuarios;
  }
}
