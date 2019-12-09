import 'package:alternative/infra/cores.dart';
import 'package:alternative/model/modelo_loja.dart';
import 'package:alternative/services/servico_loja.dart';
import 'package:alternative/singleton/singleton_usuario.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:toast/toast.dart';

import 'novo_anuncio.dart';

class NovaLojaPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _NovaLojaPageState();
}

class _NovaLojaPageState extends State<NovaLojaPage> {
  bool _loading = false;

  var servicoLoja = new ServicoLoja();

  static TextEditingController _nomeLoja = new TextEditingController();
  static TextEditingController _descricaoLoja = new TextEditingController();

  Loja novaLoja = new Loja();

  // init the step to 0th position
  int current_step = 0;

  adicionaNovaLoja() async {
    novaLoja.nome = _nomeLoja.text;
    novaLoja.idUsuario = SingletonUsuario.instance.usuarioLogado.id;
    novaLoja.avaliacao = 5;
    novaLoja.descricao = _descricaoLoja.text;
    novaLoja.foto = "";

    bool resultado = await servicoLoja.adicionaLoja(novaLoja.nome, novaLoja.avaliacao, novaLoja.idUsuario, novaLoja.descricao, novaLoja.foto);

    if(resultado){
      onSucessNovaLoja();
    } else {
      onFailNovaLoja();
    }
  }

  onSucessNovaLoja() async {
    Toast.show("Loja cadastrada com sucesso!", context, gravity: Toast.CENTER);

    if(await servicoLoja.existeLojaParaUsuario()){
    SingletonUsuario.instance.lojaUsuario = await servicoLoja.encontrePorUsuarioId();
    }

    iniciaNovoItem();
  }

  onFailNovaLoja(){
    Toast.show("Não foi possível cadastrar nova loja!", context, gravity: Toast.CENTER);
  }

  List<Step> my_steps = [
    Step(
        title: Text("Escolha um nome para a loja"),
        content: Container(
          child: TextField(
            controller: _nomeLoja,
            decoration: new InputDecoration(labelText: 'Nome da loja'),
          ),
        ),
        isActive: true),
    Step(
        title: Text("Descreva sua loja"),
        content: Container(
          child: TextField(
            controller: _descricaoLoja,
            decoration: new InputDecoration(labelText: 'Descrição da loja'),
          ),
        ),
        isActive: true),
    Step(
        title: Text("Adicione uma foto"),
        content: Container(
          child: RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(10),
                side: BorderSide(color: Cores.roxo)),
            onPressed: () {
              print("adicionar foto");
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
              Container(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.16,
                  right: MediaQuery.of(context).size.width * 0.062,
                ),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10),
                      side: BorderSide(color: Cores.roxo)),
                  onPressed: () {
                    adicionaNovaLoja();
                  },
                  color: Cores.cinzaClaro,
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Text(
                        'Cadastrar',
                        style: TextStyle(
                          color: Colors.purple,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      new Icon(
                        Icons.add_circle,
                        color: Colors.purple,
                      ),
                    ],
                  ),
                ),
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
        "Nova loja",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      centerTitle: true,
      backgroundColor: Cores.roxo,
      automaticallyImplyLeading: true,
    );
  }

  void iniciaNovoItem() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NovoAnuncioPage()),
    );
  }
}
