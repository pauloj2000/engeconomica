import 'package:alternative/bloc/bloc_pesquisa.dart';
import 'package:alternative/components/card_itens.dart';
import 'package:alternative/infra/cores.dart';
import 'package:alternative/infra/mock_db.dart';
import 'package:alternative/model/modelo_item.dart';
import 'package:alternative/services/servico_loja.dart';
import 'package:alternative/singleton/singleton_usuario.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class PesquisaPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _PesquisaPageState(_blocPesquisa);

  BlocPesquisa _blocPesquisa;

  PesquisaPage(this._blocPesquisa);
}

class _PesquisaPageState extends State<PesquisaPage> {
  final TextEditingController _controllerPesquisa = new TextEditingController();
  bool _loading = false;

  BlocPesquisa _blocPesquisa;

  @override
  void initState() {
    super.initState();
    reassemble();
  }

  _PesquisaPageState(this._blocPesquisa);

  @override
  Widget build(BuildContext context) {

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
                  _blocPesquisa.setTextoPesquisa(_controllerPesquisa.text);

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

    List<Item> listaItensAux = new List<Item>();
    List<Item> listaItens = new List<Item>();
    List<Item> listaFiltrada = new List<Item>();

    listaItensAux = BancoDadosMock.itens;

    listaItens = listaItensAux.where((item) => item.nome.toLowerCase().contains(_blocPesquisa.getTextoPesquisa().toLowerCase())).toList();

    switch(_blocPesquisa.tipoPesquisa){
      case 0:
        listaFiltrada = listaItens;
        break;
      case 1:
        var servicoLoja = new ServicoLoja();
        listaFiltrada = listaItensAux.where((item) => servicoLoja.encontrePorId(item.idLoja).idUsuario == SingletonUsuario.instance.usuarioLogado.id).toList();
        break;
      case 2:
        break;
    }

    listaFiltrada.forEach((item) => (list.add(new Padding(
        padding: EdgeInsets.only(bottom: 25), child: CardItens(item)))));

    return new Column(children: list);
  }
}
