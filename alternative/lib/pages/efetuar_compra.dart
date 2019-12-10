import 'package:alternative/components/card_dados_cartao.dart';
import 'package:alternative/infra/cores.dart';
import 'package:alternative/services/servico_carrinho_compras.dart';
import 'package:alternative/services/servico_pagamento.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

import 'inicio.dart';

class EfetuarComprasPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _EfetuarComprasPageState();
}

class _EfetuarComprasPageState extends State<EfetuarComprasPage> {
  var servicoPagamento = new ServicoPagamento();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.attach_money,
          size: MediaQuery.of(context).size.width * 0.1,
        ),
        onPressed: () {
          CarrinhoCompras.carrinhoCompras.forEach((item) {
            servicoPagamento.adicionePagamento(item.preco);
            CarrinhoCompras.removaDoCarrinho(item.id);
          });

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => InicioPage()),
          );

          Toast.show(
              "Compra efetuada com sucesso! \n\nOs detalhes da compra foram enviados por e-mail.",
              context,
              gravity: Toast.CENTER, duration: 4);
        },
        backgroundColor: Colors.green,
        foregroundColor: Cores.cinzaClaro,
      ),
      appBar: _buildBar(context),
      body: Container(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.1,
                right: MediaQuery.of(context).size.width * 0.1,
                top: MediaQuery.of(context).size.height * 0.05,
              ),
              child: Center(
                child: Text(
                  CarrinhoCompras.precoTotalCarrinho().toString(),
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 20,
                    fontFamily: "Ubuntu Bold",
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.1,
                right: MediaQuery.of(context).size.width * 0.1,
                top: MediaQuery.of(context).size.height * 0.05,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Forma de pagamento:",
                    style: TextStyle(
                      color: Cores.roxo,
                      fontSize: 12,
                      fontFamily: "Ubuntu Bold",
                    ),
                  ),
                  Text(
                    "Cartão de Crédito",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      fontFamily: "Ubuntu Bold",
                    ),
                  ),
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.1,
                  right: MediaQuery.of(context).size.width * 0.1,
                  top: MediaQuery.of(context).size.height * 0.05,
                ),
                child: CardDadosCartao()),
          ],
        ),
      ),
    );
  }

  Widget _buildBar(BuildContext context) {
    return AppBar(
      title: new Text(
        "Efetuar compra",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      centerTitle: true,
      backgroundColor: Cores.roxo,
      automaticallyImplyLeading: true,
    );
  }
}
