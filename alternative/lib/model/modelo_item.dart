import 'dart:convert';

Item itemFromJson(String str) => Item.fromJson(json.decode(str));

String itemToJson(Item data) => json.encode(data.toJson());

class Item {
  int id;
  int lojaId;
  String nome;
  double preco;

  Item({
    this.id,
    this.lojaId,
    this.nome,
    this.preco,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"],
    lojaId: json["lojaId"],
    nome: json["nome"],
    preco: json["preco"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "lojaId": lojaId,
    "nome": nome,
    "preco": preco,
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