class SingletonUsuario {

  SingletonUsuario._();

  static SingletonUsuario _instance = new SingletonUsuario._();

  static SingletonUsuario get instance => _instance;


}