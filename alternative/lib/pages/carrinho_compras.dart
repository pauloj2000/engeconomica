import 'package:alternative/components/card_itens.dart';
import 'package:alternative/infra/cores.dart';
import 'package:alternative/infra/mock_db.dart';
import 'package:alternative/model/modelo_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class CarrinhoComprasPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _CarrinhoComprasPageState();
}

class _CarrinhoComprasPageState extends State<CarrinhoComprasPage> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButton: Container(
        padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.16,
          right: MediaQuery.of(context).size.width * 0.062,
        ),
        child: RaisedButton(
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(10),
              side: BorderSide(color: Cores.roxo)),
          onPressed: () {

          },
          color: Cores.cinzaClaro,
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Text(
                'Efetuar pagamento',
                style: TextStyle(
                  color: Colors.purple,
                  fontWeight: FontWeight.bold,
                ),
              ),
              new Icon(
                Icons.monetization_on,
                color: Colors.purple,
              ),
            ],
          ),
        ),
      ),
      appBar: _buildBar(context),
      body: ModalProgressHUD(
        inAsyncCall: _loading,
        child: ListView(
          children: <Widget>[
            _getCards(),
          ],
        ),
      ),
    );
  }

  Widget _buildBar(BuildContext context) {
    return new AppBar(
      title: new Text(
        "Meu carrinho",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      centerTitle: true,
      backgroundColor: Cores.roxo,
      automaticallyImplyLeading: true,
    );
  }


  Widget _getCards() {
    List<Widget> list = new List<Widget>();

    List<Item> listaItens = new List<Item>();
    List<Item> listaAux = new List<Item>();

    listaItens = BancoDadosMock.itens;

    listaAux = listaItens.where((item) => item.carrinho == true);

    listaAux.forEach((item) => (list.add(CardItens(item))));

    return new Column(children: list);
  }
}
