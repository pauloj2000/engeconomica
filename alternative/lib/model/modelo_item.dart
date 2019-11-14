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
  bool carrinho;

  Item({
    this.id,
    this.idLoja,
    this.nome,
    this.preco,
    this.produtoDesc,
    this.producaoDesc,
    this.imagens,
    this.carrinho,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"],
    idLoja: json["idLoja"],
    nome: json["nome"],
    preco: json["preco"].toDouble(),
    produtoDesc: json["produtoDesc"],
    producaoDesc: json["producaoDesc"],
    carrinho: json["carrinho"],
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
    "carrinho": carrinho
  };
}

class Imagem {
  int id;
  String valor;

  Imagem({
    this.id,
    this.valor,
  });

  factory Imagem.fromJson(Map<String, dynamic> json) => Imagem(
    id: json["id"],
    valor: json["valor"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "valor": valor,
  };
}