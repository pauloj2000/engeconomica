import 'package:alternative/bloc/bloc_favoritos.dart';
import 'package:alternative/components/card_favoritos.dart';
import 'package:alternative/infra/cores.dart';
import 'package:alternative/pages/inicio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class FavoritosPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _FavoritosPageState();
}


class _FavoritosPageState extends State<FavoritosPage> {
  bool _loading = false;

  BlocFavoritos blocFavoritos = new BlocFavoritos();

  @override
  void initState() {
    _getCards();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: _buildBar(context),
      body: ModalProgressHUD(
        inAsyncCall: _loading,
        child: ListView(
          children: blocFavoritos.listaFavoritos,
        ),
      ),
    );
  }

  Widget _buildBar(BuildContext context) {
    return new AppBar(
      title: new Text(
        "Favoritos",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      centerTitle: true,
      backgroundColor: Cores.roxo,
      automaticallyImplyLeading: true,
    );
  }

   _getCards() {
    List<Widget> list = new List<Widget>();

    listaLojasFavoritas.forEach((loja) {
      list.add(new Padding(
          padding: EdgeInsets.only(top: 25),
          child: CardFavoritos((loja))));
    });

    blocFavoritos.setListaFavoritos(list);
  }
}
