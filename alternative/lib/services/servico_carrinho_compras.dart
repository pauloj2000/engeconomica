import 'package:alternative/model/modelo_item.dart';

class CarrinhoCompras {

  static List<Item> carrinhoCompras = new List<Item>();

  static void adicionaAoCarrinho(Item item){
    carrinhoCompras.add(item);
  }

  static bool contem(int id){
    return carrinhoCompras.where((item) => item.id == id).length > 0;
  }

  static void removaDoCarrinho(int id){
    carrinhoCompras.removeWhere((item) => item.id == id);
  }

  static double precoTotalCarrinho(){
    double total = 0.0;

    carrinhoCompras.forEach((carrinho) => (
      total += carrinho.preco
    ));

    return total;
  }

  static int quantidadeItens(){
    return carrinhoCompras.length;
  }
}