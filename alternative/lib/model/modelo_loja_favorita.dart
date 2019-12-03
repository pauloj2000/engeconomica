import 'dart:convert';

LojaFavorita lojaFavoritaFromJson(String str) => LojaFavorita.fromJson(json.decode(str));

String lojaFavoritaToJson(LojaFavorita data) => json.encode(data.toJson());

class LojaFavorita {
  int lojaId;
  String usuarioId;

  LojaFavorita({
    this.lojaId,
    this.usuarioId,
  });

  factory LojaFavorita.fromJson(Map<String, dynamic> json) => LojaFavorita(
    usuarioId: json["usuarioId"],
    lojaId: json["lojaId"],
  );

  Map<String, dynamic> toJson() => {
    "lojaId": lojaId,
    "usuarioId": usuarioId,
  };
}

class LojaFavoritaList {
  final List<LojaFavorita> lojaList;
  LojaFavoritaList({
    this.lojaList,
  });
  factory LojaFavoritaList.fromJson(List<dynamic> json) {
    return new LojaFavoritaList(
      lojaList: json.map((i) => LojaFavorita.fromJson(i)).toList(),
    );
  }
}
