import 'dart:convert';

Usuario usuarioFromJson(String str) => Usuario.fromJson(json.decode(str));

String usuarioToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
  int id;
  String nome;
  String email;
  String senha;
  String dataCriacao;


  Usuario({
    this.id,
    this.nome,
    this.email,
    this.senha,
    this.dataCriacao,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
    id: json["id"],
    nome: json["nome"],
    email: json["email"],
    senha: json["senha"],
    dataCriacao: json["dataCriacao"],
  );

  Map<String, dynamic> toJson() => {
    "nome": nome,
    "email": email,
    "senha": senha,
  };
}

class UsuarioList {
  final List<Usuario> usuarioList;
  UsuarioList({
    this.usuarioList,
  });
  factory UsuarioList.fromJson(List<dynamic> json) {
    return new UsuarioList(
      usuarioList: json.map((i) => Usuario.fromJson(i)).toList(),
    );
  }
}

