import 'package:alternative/infra/cores.dart';
import 'package:alternative/model/modelo_item.dart';
import 'package:alternative/model/modelo_loja.dart';
import 'package:alternative/pages/inicio.dart';
import 'package:alternative/services/servico_item.dart';
import 'package:alternative/services/servico_loja.dart';
import 'package:alternative/singleton/singleton_usuario.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:toast/toast.dart';

class NovoAnuncioPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _NovoAnuncioPageState();
}

class _NovoAnuncioPageState extends State<NovoAnuncioPage> {
  bool _loading = false;

  static TextEditingController _nomeProduto = new TextEditingController();
  static TextEditingController _precoProduto = new TextEditingController();
  static TextEditingController _descricaoProduto = new TextEditingController();
  static TextEditingController _descricaProducao = new TextEditingController();

  Item novoItem = new Item();

  // init the step to 0th position
  int current_step = 0;

  adicionaNovoItem() async {
    var servicoItem = new ServicoItem();

    novoItem.nome = _nomeProduto.text;
    novoItem.preco = double.parse(_precoProduto.text);

    bool adicionaItem = await servicoItem.adicioneItem(
        novoItem.nome, novoItem.preco, SingletonUsuario.instance.lojaUsuario.id);

    if (adicionaItem) {
      _sucessNovoItem();
    } else {
      _falhaNovoItem();
    }
  }

  _sucessNovoItem() {
    Toast.show("Item cadastrado com sucesso!", context, gravity: Toast.CENTER);
  }

  _falhaNovoItem() {
    Toast.show("Não foi possível cadastrar novo item!", context, gravity: Toast.CENTER);
  }

  List<Step> my_steps = [
    Step(
        title: Text("Escolha um nome para o produto"),
        content: Container(
          child: TextField(
            controller: _nomeProduto,
            decoration: new InputDecoration(labelText: 'Nome do produto'),
          ),
        ),
        isActive: true),
    Step(
        title: Text("Determine o preço"),
        content: Container(
          child: TextField(
            controller: _precoProduto,
            decoration: new InputDecoration(labelText: 'Preço em reais'),
          ),
        ),
        isActive: true),
    Step(
        title: Text("Descreva o produto"),
        content: Container(
          child: TextField(
            controller: _descricaoProduto,
            decoration: new InputDecoration(labelText: 'Descrição do produto'),
          ),
        ),
        isActive: true),
    Step(
        title: Text("Descreva a forma de produção"),
        content: Container(
          child: TextField(
            controller: _descricaProducao,
            decoration: new InputDecoration(labelText: 'Descrição da produção'),
          ),
        ),
        isActive: true),
    Step(
        title: Text("Adicione fotos"),
        content: Container(
          child: RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(10),
                side: BorderSide(color: Cores.roxo)),
            onPressed: () {
              print("adicionar fotos");
            },
            color: Cores.cinzaClaro,
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Text(
                  'Adicionar imagem',
                  style: TextStyle(
                    color: Cores.roxo,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                new Icon(
                  Icons.image,
                  color: Cores.roxo,
                ),
              ],
            ),
          ),
        ),
        isActive: true),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.done,
          size: MediaQuery.of(context).size.width * 0.1,
        ),
        onPressed: () {
          adicionaNovoItem();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => InicioPage()),
          );
        },
        backgroundColor: Colors.purple.withOpacity(0.8),
        foregroundColor: Cores.cinzaClaro,
      ),
      appBar: _buildBar(context),
      body: ModalProgressHUD(
        inAsyncCall: _loading,
        child: Container(
          child: ListView(
            children: <Widget>[
              Stepper(
                currentStep: this.current_step,
                steps: my_steps,
                type: StepperType.vertical,
                onStepTapped: (step) {
                  setState(() {
                    current_step = step;
                  });
                  print("onStepTapped : " + step.toString());
                },
                onStepCancel: () {
                  setState(() {
                    if (current_step > 0) {
                      current_step = current_step - 1;
                    } else {
                      current_step = 0;
                    }
                  });
                },
                onStepContinue: () {
                  setState(() {
                    if (current_step < my_steps.length - 1) {
                      current_step = current_step + 1;
                    } else {
                      current_step = 0;
                    }
                  });
                  print("onStepContinue : " + current_step.toString());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBar(BuildContext context) {
    return new AppBar(
      title: new Text(
        "Novo anúncio",
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
