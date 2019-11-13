import 'package:flutter/cupertino.dart';

class BlocPesquisa extends ChangeNotifier {
  String textoPesquisa = "";

  List<Widget> listaPesquisados = new List<Widget>();

  String getTextoPesquisa(){
    return textoPesquisa;
  }

  List<Widget> getListaPesquisados(){
    return listaPesquisados;
  }

  setTextoPesquisa(String _texto){
    textoPesquisa = _texto;
    notifyListeners();
  }

  setListaPesquisados(List<Widget> lista){
    listaPesquisados = lista;
    notifyListeners();
  }

  clearLista(){
    listaPesquisados.clear();
    notifyListeners();
  }

  addLista(Widget card){
    listaPesquisados.add(card);
    notifyListeners();
  }
}