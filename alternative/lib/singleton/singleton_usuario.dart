import 'package:alternative/model/modelo_loja.dart';
import 'package:alternative/model/modelo_usuario.dart';

class SingletonUsuario {

  SingletonUsuario._();

  static SingletonUsuario _instance = new SingletonUsuario._();

  static SingletonUsuario get instance => _instance;

  Usuario usuarioLogado;

  Loja lojaUsuario;
}