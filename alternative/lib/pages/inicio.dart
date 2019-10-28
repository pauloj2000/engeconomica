import 'package:alternative/infra/cores.dart';
import 'package:alternative/components/geral.dart';
import 'package:alternative/pages/search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class InicioPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {
  final TextEditingController _controllerPesquisa = new TextEditingController();
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    _controllerPesquisa.text = "";

    return Scaffold(
//      floatingActionButton: ,
      appBar: _buildBar(context),
      body: ModalProgressHUD(
        inAsyncCall: _loading,
        child: ListView(
          children: <Widget>[
            _botaoBuscar(),
            Geral.buildLogo(context, 0.18, 0.18),
            _botaoFavoritos(),
            _botaoMeusAnuncios(),
            _botaoHistoricoCompras(),
          ],
        ),
      ),
    );
  }

  Widget _buildBar(BuildContext context) {
    return new AppBar(
      title: new Text(
        "Início",
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SearchPage(_controllerPesquisa.text)),
                  );
                },
                child: Icon(
                  Icons.search,
                  color: Colors.blueAccent,
                ))),
      ),
    );
  }

  Widget _botaoFavoritos() {
    return new Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.05,
        left: MediaQuery.of(context).size.width * 0.1,
        right: MediaQuery.of(context).size.width * 0.1,
      ),
      child: new RaisedButton(
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(10),
            side: BorderSide(color: Cores.roxo)),
        onPressed: () {},
        color: Cores.cinzaClaro,
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Text(
              'Lojas favoritas',
              style: TextStyle(
                color: Cores.roxo,
                fontWeight: FontWeight.bold,
              ),
            ),
            new Icon(
              Icons.favorite_border,
              color: Cores.roxo,
            ),
          ],
        ),
      ),
    );
  }

  Widget _botaoMeusAnuncios() {
    return new Container(
      padding: EdgeInsets.only(
        left: MediaQuery.of(context).size.width * 0.1,
        right: MediaQuery.of(context).size.width * 0.1,
      ),
      child: new RaisedButton(
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(10),
            side: BorderSide(color: Cores.roxo)),
        onPressed: () {},
        color: Cores.cinzaClaro,
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Text(
              'Meus anúncios',
              style: TextStyle(
                color: Cores.roxo,
                fontWeight: FontWeight.bold,
              ),
            ),
            new Icon(
              Icons.person_pin,
              color: Cores.roxo,
            ),
          ],
        ),
      ),
    );
  }

  Widget _botaoHistoricoCompras() {
    return new Container(
      padding: EdgeInsets.only(
        left: MediaQuery.of(context).size.width * 0.1,
        right: MediaQuery.of(context).size.width * 0.1,
      ),
      child: new RaisedButton(
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(10),
            side: BorderSide(color: Cores.roxo)),
        onPressed: () {},
        color: Cores.cinzaClaro,
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Text(
              'Histórico de compras',
              style: TextStyle(
                color: Cores.roxo,
                fontWeight: FontWeight.bold,
              ),
            ),
            new Icon(
              Icons.history,
              color: Cores.roxo,
            ),
          ],
        ),
      ),
    );
  }
}
