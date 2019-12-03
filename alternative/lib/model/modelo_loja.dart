import 'dart:convert';

Loja lojaFromJson(String str) => Loja.fromJson(json.decode(str));

String lojaToJson(Loja data) => json.encode(data.toJson());

class Loja {
  int id;
  String nome;
  String descricao;
  int idUsuario;
  int avaliacao;
  String foto;

  Loja({
    this.id,
    this.nome,
    this.descricao,
    this.idUsuario,
    this.avaliacao,
    this.foto
  });

  factory Loja.fromJson(Map<String, dynamic> json) => Loja(
    id: json["id"],
    nome: json["nome"],
    idUsuario: json["idUsuario"],
    avaliacao: json["avaliavao"],
    descricao: json["descricao"],
    foto: json["foto"],
  );

  Map<String, dynamic> toJson() => {
    "nome": nome,
    "idUsuario": idUsuario,
    "avaliavao": avaliacao,
    "foto": foto,
    "descricao": descricao
  };
}

class LojaList {
  final List<Loja> lojaList;
  LojaList({
    this.lojaList,
  });
  factory LojaList.fromJson(List<dynamic> json) {
    return new LojaList(
      lojaList: json.map((i) => Loja.fromJson(i)).toList(),
    );
  }
}
