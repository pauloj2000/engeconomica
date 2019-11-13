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
  int idLoja;

  Usuario({
    this.id,
    this.nome,
    this.email,
    this.senha,
    this.dataCriacao,
    this.pagamentos,
    this.idLoja
  });

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
    id: json["id"],
    nome: json["nome"],
    email: json["email"],
    senha: json["senha"],
    dataCriacao: json["dataCriacao"],
    pagamentos: List<Pagamento>.from(json["pagamentos"].map((x) => Pagamento.fromJson(x))),
    idLoja: json["idLoja"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nome": nome,
    "email": email,
    "senha": senha,
    "dataCriacao": dataCriacao,
    "pagamentos": List<dynamic>.from(pagamentos.map((x) => x.toJson())),
    "idLoja": idLoja,
  };
}

class Pagamento {
  int mesAno;
  bool pago;
  double valor;

  Pagamento({
    this.mesAno,
    this.pago,
    this.valor,
  });

  factory Pagamento.fromJson(Map<String, dynamic> json) => Pagamento(
    mesAno: json["mesAno"],
    pago: json["pago"],
    valor: json["valor"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "mesAno": mesAno,
    "pago": pago,
    "valor": valor,
  };
}