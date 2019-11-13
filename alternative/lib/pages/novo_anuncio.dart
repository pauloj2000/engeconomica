import 'package:alternative/infra/cores.dart';
import 'package:alternative/infra/mock_db.dart';
import 'package:alternative/model/modelo_item.dart';
import 'package:alternative/services/servico_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

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


  adicionaNovoItem(){
    var servicoItem = new ServicoItem();

    novoItem.id = BancoDadosMock.itens.last.id + 1;
    novoItem.nome = _nomeProduto.text;
    novoItem.preco = double.parse(_precoProduto.text);
    novoItem.produtoDesc = _descricaoProduto.text;
    novoItem.producaoDesc = _descricaProducao.text;
    novoItem.imagens = null;

    servicoItem.adicionaItem(novoItem.id, 1, novoItem.nome, novoItem.preco, novoItem.produtoDesc, novoItem.producaoDesc, novoItem.imagens);

    servicoItem = null;
  }

  List<Step> my_steps = [
    Step(
        // Title of the Step
        title: Text("Escolha um nome para o produto"),
        // Content, it can be any widget here. Using basic Text for this example
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
//          padding: EdgeInsets.only(
//            right: 60,
//          ),
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
      appBar: _buildBar(context),
      body: ModalProgressHUD(
        inAsyncCall: _loading,
        child: Container(
          child: ListView(
            children: <Widget>[
              Stepper(
                // Using a variable here for handling the currentStep
                currentStep: this.current_step,
                // List the steps you would like to have
                steps: my_steps,
                // Define the type of Stepper style
                // StepperType.horizontal :  Horizontal Style
                // StepperType.vertical   :  Vertical Style
                type: StepperType.vertical,
                // Know the step that is tapped
                onStepTapped: (step) {
                  // On hitting step itself, change the state and jump to that step
                  setState(() {
                    // update the variable handling the current step value
                    // jump to the tapped step
                    current_step = step;
                  });
                  // Log function call
                  print("onStepTapped : " + step.toString());
                },
                onStepCancel: () {
                  // On hitting cancel button, change the state
                  setState(() {
                    // update the variable handling the current step value
                    // going back one step i.e subtracting 1, until its 0
                    if (current_step > 0) {
                      current_step = current_step - 1;
                    } else {
                      current_step = 0;
                    }
                  });
                  // Log function call
                  print("onStepCancel : " + current_step.toString());
                },
                // On hitting continue button, change the state
                onStepContinue: () {
                  setState(() {
                    // update the variable handling the current step value
                    // going back one step i.e adding 1, until its the length of the step
                    if (current_step < my_steps.length - 1) {
                      current_step = current_step + 1;
                    } else {
                      current_step = 0;
                    }
                  });
                  // Log function call
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
                      adicionaNovoItem();

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
