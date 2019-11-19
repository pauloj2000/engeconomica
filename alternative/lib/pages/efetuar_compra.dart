import 'package:alternative/components/card_dados_cartao.dart';
import 'package:alternative/infra/cores.dart';
import 'package:alternative/services/servico_carrinho_compras.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EfetuarComprasPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _EfetuarComprasPageState();
}

class _EfetuarComprasPageState extends State<EfetuarComprasPage> {
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
          Navigator.pop(context);
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
                child: CardDadosCartao()
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBar(BuildContext context) {
    return new AppBar(
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
