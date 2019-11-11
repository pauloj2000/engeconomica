import 'dart:convert';

Loja lojaFromJson(String str) => Loja.fromJson(json.decode(str));

String lojaToJson(Loja data) => json.encode(data.toJson());

class Loja {
  int id;
  String nome;
  int idUsuario;
  double caixa;
  double valorTotalRecebido;
  int avaliacao;

  Loja({
    this.id,
    this.nome,
    this.idUsuario,
    this.caixa,
    this.valorTotalRecebido,
    this.avaliacao,
  });

  factory Loja.fromJson(Map<String, dynamic> json) => Loja(
    id: json["id"],
    nome: json["nome"],
    idUsuario: json["idUsuario"],
    caixa: json["caixa"].toDouble(),
    valorTotalRecebido: json["valorTotalRecebido"].toDouble(),
    avaliacao: json["avaliacao"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nome": nome,
    "idUsuario": idUsuario,
    "caixa": caixa,
    "valorTotalRecebido": valorTotalRecebido,
    "avaliacao": avaliacao,
  };
}
