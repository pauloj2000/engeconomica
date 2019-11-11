import 'package:alternative/infra/cores.dart';
import 'package:alternative/components/geral.dart';
import 'package:alternative/infra/mockDb.dart';
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
  @override
  void initState() {
    BancoDadosMock.iniciaMock();
    super.initState();
  }

  final TextEditingController _emailFilter = new TextEditingController();
  final TextEditingController _passwordFilter = new TextEditingController();
  String _email = "";
  String _password = "";
  FormType _form = FormType
      .login; // our default setting is to login, and we should switch to creating an account when the user chooses to

  _LoginPageState() {
    _emailFilter.addListener(_emailListen);
    _passwordFilter.addListener(_passwordListen);
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
              decoration: new InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
          )
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

  bool validaEmail(String _email){
    if(!_email.contains("@")){
      return false;
    }

    if(!_email.contains(".com")){
      return false;
    }

    return true;
  }

  void _loginPressed() {
    if(validaEmail(_email)){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => InicioPage()),
      );
    } else {
      Toast.show("O e-mail informado é inválido", context);
    }
  }

  void _createAccountPressed() {
    print('The user wants to create an accoutn with $_email and $_password');
  }

  void _passwordReset() {
    print("The user wants a password reset request sent to $_email");
  }
}
