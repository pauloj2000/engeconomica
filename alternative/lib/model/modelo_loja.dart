import 'dart:convert';

Loja lojaFromJson(String str) => Loja.fromJson(json.decode(str));

String lojaToJson(Loja data) => json.encode(data.toJson());

class Loja {
  int id;
  String nome;
  String descricao;
  int idUsuario;
  double caixa;
  double valorTotalRecebido;
  int avaliacao;
  String foto;

  Loja({
    this.id,
    this.nome,
    this.descricao,
    this.idUsuario,
    this.caixa,
    this.valorTotalRecebido,
    this.avaliacao,
    this.foto
  });

  factory Loja.fromJson(Map<String, dynamic> json) => Loja(
    id: json["id"],
    nome: json["nome"],
    idUsuario: json["idUsuario"],
    caixa: json["caixa"].toDouble(),
    valorTotalRecebido: json["valorTotalRecebido"].toDouble(),
    avaliacao: json["avaliacao"],
    descricao: json["descricao"],
    foto: json["foto"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nome": nome,
    "idUsuario": idUsuario,
    "caixa": caixa,
    "valorTotalRecebido": valorTotalRecebido,
    "avaliacao": avaliacao,
    "foto": foto,
    "descricao": descricao
  };
}
