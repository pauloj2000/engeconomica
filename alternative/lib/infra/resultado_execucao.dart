class ResultadoExecucao{

  bool _resultado;
  String _mensagem;

  ResultadoExecucao(this._resultado, this._mensagem);

  String retornaMensagemErro(){
    return _mensagem;
  }

  bool sucesso(){
    return _resultado;
  }

  adicioneMensagemErro(String mensagem){
    _mensagem += mensagem;
  }

  setResultado(bool resultado){
    _resultado = resultado;
  }

}