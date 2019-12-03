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

  Item({
    this.id,
    this.idLoja,
    this.nome,
    this.preco,
    this.produtoDesc,
    this.producaoDesc,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"],
    idLoja: json["idLoja"],
    nome: json["nome"],
    preco: json["preco"].toDouble(),
    produtoDesc: json["produtoDesc"],
    producaoDesc: json["producaoDesc"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "idLoja": idLoja,
    "nome": nome,
    "preco": preco,
    "produtoDesc": produtoDesc,
    "producaoDesc": producaoDesc,
  };
}

class ItemList {
  final List<Item> itemList;
  ItemList({
    this.itemList,
  });
  factory ItemList.fromJson(List<dynamic> json) {
    return new ItemList(
      itemList: json.map((i) => Item.fromJson(i)).toList(),
    );
  }
}