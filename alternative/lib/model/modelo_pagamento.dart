class Pagamento {
  int id;
  String dataPag;
  double valor;
  int usuarioId;

  Pagamento({
    this.id,
    this.dataPag,
    this.valor,
    this.usuarioId,
  });

  factory Pagamento.fromJson(Map<String, dynamic> json) => Pagamento(
    dataPag: json["dataPag"],
    valor: json["valor"].toDouble(),
    id: json["id"],
    usuarioId: json["usuarioId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "dataPag": dataPag,
    "valor": valor,
    "usuarioId": usuarioId,
  };
}

class PagamentoList {
  final List<Pagamento> pagamentoList;
  PagamentoList({
    this.pagamentoList,
  });
  factory PagamentoList.fromJson(List<dynamic> json) {
    return new PagamentoList(
      pagamentoList: json.map((i) => Pagamento.fromJson(i)).toList(),
    );
  }
}
