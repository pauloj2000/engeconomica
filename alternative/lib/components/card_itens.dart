import 'package:alternative/infra/cores.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

// ignore: must_be_immutable
class CardItens extends StatelessWidget {
  String _tituloCard;

  CardItens(this._tituloCard);

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
                    right: MediaQuery.of(context).size.width * 0.02,
                  ),
                  child: Text(
                    "#1214",
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.025,
              bottom: MediaQuery.of(context).size.height * 0.015,
            ),
            child: Container(
              height: 2,
              color: Colors.grey.withOpacity(0.6),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.02,
              left: MediaQuery.of(context).size.width * 0.06,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Preço:  ",
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "R\$ 17",
                  style: TextStyle(
                    color: Cores.roxo,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.035,
                left: MediaQuery.of(context).size.width * 0.06,
              ),
              child: Text(
                "Descrição:  ",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.01,
                left: MediaQuery.of(context).size.width * 0.06,
                right: MediaQuery.of(context).size.width * 0.02,
              ),
              child: Text(
                "A descrição do produto tem como objetivo explicitar pontos importantes para o cliente.",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.05,
              left: MediaQuery.of(context).size.width * 0.06,
              right: MediaQuery.of(context).size.width * 0.06,
              bottom: MediaQuery.of(context).size.height * 0.03,
            ),
            child: Image.asset(
              "assets/images/colar_madeira.png",
              height: MediaQuery.of(context).size.height * 0.2,
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
                "Comprar",
                style: TextStyle(color: Colors.black54),
              ),
              GestureDetector(
                onTap: () {
                  Toast.show("Item adicionado ao carrinho!", context);
                },
                child: Image.asset(
                  "assets/images/carrinho_compra.png",
                  height: MediaQuery.of(context).size.height * 0.06,
                ),
              ),
              Text(
                "Favoritar",
                style: TextStyle(color: Colors.black54),
              ),
              GestureDetector(
                onTap: () {
                  Toast.show("Loja adicionada aos favoritos!", context);
                },
                child: IconButton(
                  icon: Icon(
                    Icons.favorite,
                    color: Colors.purple,
                  ),
                ),
              )
            ],
          ),
        ]),
      ),
    );
  }
}
