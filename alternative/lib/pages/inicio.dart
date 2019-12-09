import 'package:alternative/bloc/bloc_pesquisa.dart';
import 'package:alternative/infra/cores.dart';
import 'package:alternative/components/geral.dart';
import 'package:alternative/pages/carrinho_compras.dart';
import 'package:alternative/pages/favoritos.dart';
import 'package:alternative/pages/historico.dart';
import 'package:alternative/pages/nova_loja.dart';
import 'package:alternative/pages/novo_anuncio.dart';
import 'package:alternative/pages/pesquisa.dart';
import 'package:alternative/services/servico_carrinho_compras.dart';
import 'package:alternative/services/servico_item.dart';
import 'package:alternative/services/servico_loja.dart';
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

  var servicoLoja = new ServicoLoja();

  BlocPesquisa _blocPesquisa = new BlocPesquisa();

  iniciaItens() async {
      listaItensPesquisa = await ServicoItem().getItens();
  }

  @override
  Widget build(BuildContext context) {
    iniciaItens();

    _controllerPesquisa.text = "";

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          size: MediaQuery.of(context).size.width * 0.1,
        ),
        onPressed: () async {
          bool existeLoja = await servicoLoja.existeLojaParaUsuario();

          if (existeLoja) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NovoAnuncioPage()),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NovaLojaPage()),
            );
          }
        },
        backgroundColor: Colors.purple.withOpacity(0.8),
        foregroundColor: Cores.cinzaClaro,
      ),
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
            CarrinhoCompras.quantidadeItens() > 0
                ? _botaoCarrinhoCompras()
                : Container(),
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
                  _blocPesquisa.setTextoPesquisa(_controllerPesquisa.text);
                  _blocPesquisa.setTipoPesquisa(0);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PesquisaPage(_blocPesquisa)),
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
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FavoritosPage()),
          );
        },
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
        onPressed: () {
          _blocPesquisa.setTipoPesquisa(1);

          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PesquisaPage(_blocPesquisa)),
          );
        },
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
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HistoricoPage()),
          );
        },
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

  Widget _botaoCarrinhoCompras() {
    return new Container(
      padding: EdgeInsets.only(
        left: MediaQuery.of(context).size.width * 0.1,
        right: MediaQuery.of(context).size.width * 0.1,
      ),
      child: new RaisedButton(
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(10),
            side: BorderSide(color: Cores.roxo)),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CarrinhoComprasPage()),
          );
        },
        color: Cores.cinzaClaro,
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Text(
              'Meu carrinho',
              style: TextStyle(
                color: Cores.roxo,
                fontWeight: FontWeight.bold,
              ),
            ),
            new Icon(
              Icons.add_shopping_cart,
              color: Cores.roxo,
            ),
          ],
        ),
      ),
    );
  }
}
