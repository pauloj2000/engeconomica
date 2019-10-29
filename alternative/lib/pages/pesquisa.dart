import 'package:alternative/components/card_itens.dart';
import 'package:alternative/infra/cores.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class PesquisaPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _PesquisaPageState(_textoBusca);

  String _textoBusca;

  PesquisaPage(this._textoBusca);
}

class _PesquisaPageState extends State<PesquisaPage> {
  final TextEditingController _controllerPesquisa = new TextEditingController();
  bool _loading = false;

  String _textoBusca = "";

  _PesquisaPageState(this._textoBusca);

  @override
  Widget build(BuildContext context) {
    if (_textoBusca != null && _textoBusca.isNotEmpty) {
      _controllerPesquisa.text = _textoBusca;
      _textoBusca = "";
    }

    return Scaffold(
      appBar: _buildBar(context),
      body: ModalProgressHUD(
        inAsyncCall: _loading,
        child: ListView(
          children: <Widget>[
            _botaoBuscar(),
            _getCards(_controllerPesquisa.text),
          ],
        ),
      ),
    );
  }

  Widget _buildBar(BuildContext context) {
    return new AppBar(
      title: new Text(
        "Itens",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      centerTitle: true,
      backgroundColor: Cores.roxo,
      automaticallyImplyLeading: true,
    );
  }

  Widget _botaoBuscar() {
    return new Container(
      padding: EdgeInsets.only(
        left: MediaQuery.of(context).size.width * 0.1,
        right: MediaQuery.of(context).size.width * 0.1,
        bottom: MediaQuery.of(context).size.height * 0.05,
      ),
      child: TextField(
        style: TextStyle(color: Colors.black54),
        controller: _controllerPesquisa,
        decoration: new InputDecoration(
            labelText: 'Buscar',
            suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    build(context);
                  });
                },
                child: Icon(
                  Icons.search,
                  color: Colors.blueAccent,
                ))),
      ),
    );
  }

  Widget _getCards(String tituloCard) {
    List<Widget> list = new List<Widget>();
    for (var i = 1; i < 4; i++) {
      list.add(new Padding(
          padding: EdgeInsets.only(bottom: 25),
          child: CardItens(tituloCard +
              (i == 1 ? "" : i == 2 ? " (Semi-novo)" : " (Usado)"))));
    }
    return new Column(children: list);
  }
}
