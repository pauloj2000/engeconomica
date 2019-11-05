import 'package:alternative/infra/cores.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class CardHistorico extends StatelessWidget {
  String _tituloCard;

  CardHistorico(this._tituloCard);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.02,
              left: MediaQuery.of(context).size.width * 0.06,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  _tituloCard != null ? _tituloCard : "-",
                  style: TextStyle(
                      color: Cores.roxo,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    right: MediaQuery.of(context).size.width * 0.01,
                  ),
                  child: Text(
                    "Valor:",
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 12,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    right: MediaQuery.of(context).size.width * 0.02,
                  ),
                  child: Text(
                    " R\$ 33",
                    style: TextStyle(
                      color: Colors.purple,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.015,
//              bottom: MediaQuery.of(context).size.height * 0.005,
            ),
            child: Container(
              height: 2,
              color: Cores.roxo.withOpacity(0.6),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                "Detalhamento",
                style: TextStyle(color: Colors.black54),
              ),
              GestureDetector(
                onTap: () {
                  _mostreDetalhamento(context);
                },
                child: IconButton(
                  icon: Icon(
                    Icons.info,
                    color: Colors.purple,
                  ),
                ),
              ),
              Text(
                "Reclamações",
                style: TextStyle(color: Colors.black54),
              ),
              GestureDetector(
                onTap: () {
                  _abreReclamacao(context);
                },
                child: IconButton(
                  icon: Icon(
                    Icons.mail_outline,
                    color: Colors.purple,
                  ),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}

void _mostreDetalhamento(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // retorna um objeto do tipo Dialog
      return AlertDialog(
        title: new Text("Detalhamento do item"),
        content: new Text(""),
        actions: <Widget>[
          // define os botões na base do dialogo
          new FlatButton(
            child: new Text("Fechar"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

void _abreReclamacao(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // retorna um objeto do tipo Dialog
      return AlertDialog(
        title: new Text("Reclamação"),
        content: new Text(""),
        actions: <Widget>[
          // define os botões na base do dialogo
          new FlatButton(
            child: new Text("Fechar"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
