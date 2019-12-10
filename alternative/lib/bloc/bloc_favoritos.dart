import 'package:flutter/cupertino.dart';

class BlocFavoritos extends ChangeNotifier {
  List<Widget> listaFavoritos = new List<Widget>();

  List<Widget> getListaFavoritos(){
    return listaFavoritos;
  }

  setListaFavoritos(List<Widget> lista){
    listaFavoritos = lista;
    notifyListeners();
  }

  clearLista(){
    listaFavoritos.clear();
    notifyListeners();
  }

  addLista(Widget card){
    listaFavoritos.add(card);
    notifyListeners();
  }
}