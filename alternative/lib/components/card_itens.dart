import 'package:alternative/bloc/bloc_pesquisa.dart';
import 'package:alternative/infra/cores.dart';
import 'package:alternative/model/modelo_item.dart';
import 'package:alternative/pages/pesquisa.dart';
import 'package:alternative/services/servico_carrinho_compras.dart';
import 'package:alternative/services/servico_favoritos.dart';
import 'package:alternative/services/servico_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class CardItens extends StatelessWidget {
  Item item;

  bool meusItens;

  CardItens(this.item, this.meusItens);

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
                Visibility(
                  visible: meusItens == false,
                  child: Text(
                    CarrinhoCompras.contem(item.id) ? "Remover" : "Comprar",
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
                Visibility(
                  visible: meusItens == false,
                  child: GestureDetector(
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
                ),
                Visibility(
                  visible: meusItens == true,
                  child: Text(
                    "Editar",
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
                Visibility(
                  visible: meusItens == true,
                  child: IconButton(
                    icon: Icon(Icons.edit,
                      color: Colors.purple,
                    ),
                  ),
                ),
                Text(
                  meusItens == false ? "Favoritar" : "Excluir",
                  style: TextStyle(color: Colors.black54),
                ),
                GestureDetector(
                  onTap: () async {
                    if(meusItens){
                      await ServicoItem().excluiItem(item.id);

                      Navigator.pop(context);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PesquisaPage(BlocPesquisa(), 1)),
                      );

                      Toast.show("Item removido!", context);
                    } else {
                      await ServicoLojasFavoritas().adicioneItem(item.id);
                      Toast.show("Loja adicionada aos favoritos!", context);
                    }
                  },
                  child: IconButton(
                    icon: Icon(
                      meusItens == false
                          ? Icons.favorite
                          : Icons.delete_forever,
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
