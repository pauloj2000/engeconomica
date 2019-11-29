import 'dart:convert';

Item itemFromJson(String str) => Item.fromJson(json.decode(str));

String itemToJson(Item data) => json.encode(data.toJson());

class Item {
  int id;
  int idLoja;
  String nome;
  double preco;
  String produtoDesc;
  String producaoDesc;
  List<Imagem> imagens;

  Item({
    this.id,
    this.idLoja,
    this.nome,
    this.preco,
    this.produtoDesc,
    this.producaoDesc,
    this.imagens,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"],
    idLoja: json["idLoja"],
    nome: json["nome"],
    preco: json["preco"].toDouble(),
    produtoDesc: json["produtoDesc"],
    producaoDesc: json["producaoDesc"],
    imagens: List<Imagem>.from(json["imagens"].map((x) => Imagem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "idLoja": idLoja,
    "nome": nome,
    "preco": preco,
    "produtoDesc": produtoDesc,
    "producaoDesc": producaoDesc,
    "imagens": List<dynamic>.from(imagens.map((x) => x.toJson())),
  };
}

class Imagem {
  int id;
  int tipoImagem; // loja ou item
  int idVinculo;
  String valor;

  Imagem({
    this.id,
    this.valor,
    this.tipoImagem,
    this.idVinculo,
  });

  factory Imagem.fromJson(Map<String, dynamic> json) => Imagem(
    id: json["id"],
    valor: json["valor"],
    idVinculo: json["idVinculo"],
    tipoImagem: json["tipoImagem"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "valor": valor,
    "idVinculo": idVinculo,
    "tipoImagem": tipoImagem,
  };
}