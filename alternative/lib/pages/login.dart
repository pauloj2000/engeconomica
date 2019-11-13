import 'package:alternative/infra/cores.dart';
import 'package:alternative/components/geral.dart';
import 'package:alternative/infra/mock_db.dart';
import 'package:alternative/infra/resultado_execucao.dart';
import 'package:alternative/infra/util.dart';
import 'package:alternative/model/modelo_usuario.dart';
import 'package:alternative/services/servico_usuario.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

import 'inicio.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}

// Used for controlling whether the user is loggin or creating an account
enum FormType { login, register }

class _LoginPageState extends State<LoginPage> {

  ServicoUsuario servicoUsuario;

  @override
  void initState() {
    BancoDadosMock.iniciaMock();
    servicoUsuario = new ServicoUsuario();
    super.initState();
  }

  final TextEditingController _emailFilter = new TextEditingController();
  final TextEditingController _passwordFilter = new TextEditingController();
  final TextEditingController _nomeFilter = new TextEditingController();

  String _email = "";
  String _password = "";
  String _nome = "";

  FormType _form = FormType
      .login; // our default setting is to login, and we should switch to creating an account when the user chooses to

  _LoginPageState() {
    _emailFilter.addListener(_emailListen);
    _passwordFilter.addListener(_passwordListen);
    _nomeFilter.addListener(_nomeListen);
  }

  void _emailListen() {
    if (_emailFilter.text.isEmpty) {
      _email = "";
    } else {
      _email = _emailFilter.text;
    }
  }

  void _passwordListen() {
    if (_passwordFilter.text.isEmpty) {
      _password = "";
    } else {
      _password = _passwordFilter.text;
    }
  }

  void _nomeListen(){
    if (_nomeFilter.text.isEmpty) {
      _nome = "";
    } else {
      _nome = _nomeFilter.text;
    }
  }

  // Swap in between our two forms, registering and logging in
  void _formChange() async {
    setState(() {
      if (_form == FormType.register) {
        _form = FormType.login;
      } else {
        _form = FormType.register;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: _buildBar(context),
      body: ListView(
        children: <Widget>[
          Geral.buildLogo(context, 0.1, 0.2),
          _buildTextFields(),
          _buildButtons(),
        ],
      ),
    );
  }

  Widget _buildBar(BuildContext context) {
    return new AppBar(
      title: new Text(
        "Login",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      centerTitle: true,
      backgroundColor: Cores.roxo,
    );
  }

  Widget _buildTextFields() {
    return new Container(
      padding: EdgeInsets.only(
        left: MediaQuery.of(context).size.width * 0.1,
        right: MediaQuery.of(context).size.width * 0.1,
      ),
      child: new Column(
        children: <Widget>[
          new Container(
            child: new TextField(
              controller: _emailFilter,
              decoration: new InputDecoration(labelText: 'Email'),
            ),
          ),
          new Container(
            child: new TextField(
              controller: _passwordFilter,
              decoration: new InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
          ),
          _form == FormType.register ? Container(
            child: new TextField(
              controller: _nomeFilter,
              decoration: new InputDecoration(labelText: 'Nome'),
            ),
          ) : Container(),
        ],
      ),
    );
  }

  Widget _buildButtons() {
    if (_form == FormType.login) {
      return new Container(
        child: new Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.05,
                bottom: MediaQuery.of(context).size.height * 0.04,
              ),
              child: RaisedButton(
                child: new Text(
                  'Login',
                  style: TextStyle(
                    color: Cores.roxo,
                    fontSize: 15,
                  ),
                ),
                onPressed: _loginPressed,
              ),
            ),
            new FlatButton(
              child: new Text('Dont have an account? Tap here to register.',
                  style: TextStyle(
                    color: Colors.blueAccent,
                  )),
              onPressed: _formChange,
            ),
            new FlatButton(
              child: new Text('Forgot Password?',
                  style: TextStyle(
                    color: Colors.blueAccent,
                  )),
              onPressed: _passwordReset,
            )
          ],
        ),
      );
    } else {
      return new Container(
        child: new Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.05,
                bottom: MediaQuery.of(context).size.height * 0.04,
              ),
              child: RaisedButton(
                child: new Text(
                  'Create an Account',
                  style: TextStyle(
                    color: Cores.roxo,
                    fontSize: 15,
                  ),
                ),
                onPressed: _createAccountPressed,
              ),
            ),
            new FlatButton(
              child: new Text('Have an account? Click here to login.',
                  style: TextStyle(
                    color: Colors.blueAccent,
                  )),
              onPressed: _formChange,
            )
          ],
        ),
      );
    }
  }

  // These functions can self contain any user auth logic required, they all have access to _email and _password

  ResultadoExecucao validaEmail(String _email, String _senha) {
    var resultado = new ResultadoExecucao(true, "");

    if (!_email.contains("@") || !_email.contains(".com")) {
      resultado.setResultado(false);
      resultado.adicioneMensagemErro("E-mail inválido!");
      return resultado;
    }

    resultado = validaEntradaUsuario(_email, _senha);

    return resultado;
  }

  ResultadoExecucao validaEntradaUsuario(String _email, String _senha) {
    var resultado = new ResultadoExecucao(true, "");

    List<Usuario> listaUsuarios = BancoDadosMock.usuarios;
    List<Usuario> listaAux = new List<Usuario>();

    listaAux = listaUsuarios.where((usuario) => usuario.email == _email).toList();

    if (listaAux.length == 0) {
      resultado.setResultado(false);
      resultado
          .adicioneMensagemErro("O email informado ainda não foi cadastrado!");
      return resultado;
    }

    resultado = verificaLoginESenha(_email, _senha);

    return resultado;
  }

  ResultadoExecucao verificaLoginESenha(String _email, String _senha) {
    var resultado = new ResultadoExecucao(true, "");

    List<Usuario> listaUsuarios = BancoDadosMock.usuarios;
    List<Usuario> listaAux = new List<Usuario>();

    listaAux = listaUsuarios
        .where((usuario) => usuario.email == _email && usuario.senha == _senha).toList();

    if (listaAux.length == 0) {
      resultado.setResultado(false);
      resultado.adicioneMensagemErro("A senha está incorreta.");
    }

    return resultado;
  }

  void _loginPressed() {
    var resultado = validaEmail(_email, _password);

    if (resultado.sucesso()) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => InicioPage()),
      );
    } else {
      Toast.show(resultado.retornaMensagemErro(), context, gravity: Toast.CENTER, duration: 3);
    }
  }

  void _createAccountPressed() {
    servicoUsuario.adicionaUsuario(BancoDadosMock.usuarios.last.id + 1, _nome, _email, _password, Util.retornaDataFormatada(DateTime.now()), new List<Pagamento>());

    _formChange();

    Toast.show("Usuário cadastrado com sucesso!", context,
        duration: 3, gravity: Toast.CENTER);
  }

  void _passwordReset() {
    print("The user wants a password reset request sent to $_email");
  }
}
