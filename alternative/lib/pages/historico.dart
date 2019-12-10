import 'package:alternative/components/card_historico.dart';
import 'package:alternative/infra/cores.dart';
import 'package:alternative/model/modelo_pagamento.dart';
import 'package:alternative/pages/inicio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class HistoricoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _HistoricoPageState();

}

class _HistoricoPageState extends State<HistoricoPage> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: _buildBar(context),
      body: ModalProgressHUD(
        inAsyncCall: _loading,
        child: ListView(
          children: <Widget>[
            listaPagamentos != null && listaPagamentos.length > 0 ? _getCards() : Container(),
          ],
        ),
      ),
    );
  }

  Widget _buildBar(BuildContext context) {
    return new AppBar(
      title: new Text(
        "Histórico de pagamentos",
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

    List<Pagamento> listaAux = listaPagamentos;

    listaAux.forEach((pagamento){
      list.add(new Padding(
          padding: EdgeInsets.only(top: 25),
          child:CardHistorico((pagamento))));
    });

    return new Column(children: list);
  }
}
