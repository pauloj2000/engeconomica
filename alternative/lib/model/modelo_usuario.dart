import 'dart:convert';

Usuario usuarioFromJson(String str) => Usuario.fromJson(json.decode(str));

String usuarioToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
  int id;
  String nome;
  String email;
  String senha;
  String dataCriacao;
  List<Pagamento> pagamentos;
  List<int> lojasFavoritas;
  List<int> carrinho;

  Usuario({
    this.id,
    this.nome,
    this.email,
    this.senha,
    this.dataCriacao,
    this.pagamentos,
    this.lojasFavoritas,
    this.carrinho,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
    id: json["id"],
    nome: json["nome"],
    email: json["email"],
    senha: json["senha"],
    dataCriacao: json["dataCriacao"],
    pagamentos: List<Pagamento>.from(json["pagamentos"].map((x) => Pagamento.fromJson(x))),
    lojasFavoritas: List<int>.from(json["lojasFavoritas"].map((x) => x)),
    carrinho: List<int>.from(json["carrinho"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nome": nome,
    "email": email,
    "senha": senha,
    "dataCriacao": dataCriacao,
    "pagamentos": List<dynamic>.from(pagamentos.map((x) => x.toJson())),
    "lojasFavoritas": List<int>.from(lojasFavoritas.map((x) => x)),
    "carrinho": List<int>.from(carrinho.map((x) => x)),
  };
}

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
    "id": id
  };
}