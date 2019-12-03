class Pagamento {
  BigInt id;
  String dataPag;
  double valor;
  BigInt idItem;
  BigInt idUsuario;

  Pagamento({
    this.id,
    this.dataPag,
    this.valor,
    this.idItem,
    this.idUsuario,
  });

  factory Pagamento.fromJson(Map<String, dynamic> json) => Pagamento(
    dataPag: json["dataPag"],
    valor: json["valor"].toDouble(),
    idItem: json["idItem"],
    id: json["id"],
    idUsuario: json["idUsuario"],
  );

  Map<String, dynamic> toJson() => {
    "dataPag": dataPag,
    "valor": valor,
    "idItem": idItem,
    "idUsuario": idUsuario,
  };
}