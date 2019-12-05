import 'package:alternative/infra/cores.dart';
import 'package:alternative/model/modelo_item.dart';
import 'package:alternative/services/servico_carrinho_compras.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class CardItens extends StatelessWidget {
  Item item;

  CardItens(this.item);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 25),
      child: Card(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Column(children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.02,
                left: MediaQuery.of(context).size.width * 0.06,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    item.nome != null ? item.nome : "-",
                    style: TextStyle(
                        color: Cores.roxo,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      right: MediaQuery.of(context).size.width * 0.02,
                    ),
                    child: Text(
                      item.id != null ? "#" + item.id.toString() : "-",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.025,
                bottom: MediaQuery.of(context).size.height * 0.015,
              ),
              child: Container(
                height: 2,
                color: Colors.grey.withOpacity(0.6),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.02,
                left: MediaQuery.of(context).size.width * 0.06,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Preço:  ",
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    item.preco != null
                        ? "R\$ " +
                            item.preco
                                .toStringAsFixed(2)
                                .toString()
                                .replaceAll(".", ",")
                        : "-",
                    style: TextStyle(
                      color: Cores.roxo,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.05,
                left: MediaQuery.of(context).size.width * 0.06,
                right: MediaQuery.of(context).size.width * 0.06,
                bottom: MediaQuery.of(context).size.height * 0.03,
              ),
              child: Image.asset(
                "assets/images/imagem_indisponivel.png",
                height: MediaQuery.of(context).size.height * 0.35,
                width: MediaQuery.of(context).size.width * 0.5,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.015,
              ),
              child: Container(
                height: 2,
                color: Cores.roxo.withOpacity(0.6),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  CarrinhoCompras.contem(item.id) ? "Remover" : "Comprar",
                  style: TextStyle(color: Colors.black54),
                ),
                GestureDetector(
                  onTap: () {
                    if (CarrinhoCompras.contem(item.id) == false) {
                      CarrinhoCompras.adicionaAoCarrinho(item);
                      Toast.show("Item adicionado ao carrinho!", context);
                    } else {
                      CarrinhoCompras.removaDoCarrinho(item.id);
                      Toast.show("Item removido do carrinho!", context);
                    }
                  },
                  child: Image.asset(
                    "assets/images/carrinho_compra.png",
                    height: MediaQuery.of(context).size.height * 0.06,
                  ),
                ),
                Text(
                  "Favoritar",
                  style: TextStyle(color: Colors.black54),
                ),
                GestureDetector(
                  onTap: () {
                    Toast.show("Loja adicionada aos favoritos!", context);
                  },
                  child: IconButton(
                    icon: Icon(
                      Icons.favorite,
                      color: Colors.purple,
                    ),
                  ),
                )
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
