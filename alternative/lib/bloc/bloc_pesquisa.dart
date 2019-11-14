import 'package:flutter/cupertino.dart';

class BlocPesquisa extends ChangeNotifier {
  String textoPesquisa = "";

  List<Widget> listaPesquisados = new List<Widget>();

  int tipoPesquisa = 0;

  String getTextoPesquisa(){
    return textoPesquisa;
  }

  int getTipoPesquisa(){
    return tipoPesquisa;
  }

  List<Widget> getListaPesquisados(){
    return listaPesquisados;
  }

  setTipoPesquisa(int tipoPesquisa){
    tipoPesquisa = tipoPesquisa;
    notifyListeners();
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