import 'package:alternative/model/modelo_item.dart';
import 'package:alternative/model/modelo_loja.dart';
import 'package:alternative/model/modelo_usuario.dart';

class BancoDadosMock {

  static List<Usuario> usuarios;
  static List<Loja> lojas;
  static List<Item> itens;

  static void iniciaMock(){
    usuarios = new List<Usuario>();
    lojas = new List<Loja>();
    itens = new List<Item>();

    Usuario user = new Usuario();
    user.id = 1;
    user.nome = "João Felipe das Neves";
    user.dataCriacao = '11/11/2019';
    user.email = "joaofelipe@gmail.com";
    user.senha = "123456789";

    usuarios.add(user);

    Usuario user2 = new Usuario();
    user2.id = 2;
    user2.nome = "Zé Ricardo Dantas de Sá";
    user2.dataCriacao = '11/11/2019';
    user2.email = "josericardo@gmail.com";
    user2.senha = "123456789";

    usuarios.add(user2);

    Loja loja1 = new Loja(id: 1, idUsuario: 1, nome: "Indio Maluco", avaliacao: 5);
    Loja loja2 = new Loja(id: 2, idUsuario: 1, nome: "Artesãonato", avaliacao: 5);
    Loja loja3 = new Loja(id: 3, idUsuario: 2, nome: "Miçangas do Zé", avaliacao: 5);

    lojas.add(loja1);
    lojas.add(loja2);
    lojas.add(loja3);

    Item item1 = new Item(id: 1, idLoja: 1, nome: "Cocar Indígena Vermelho Simples");
    Item item2 = new Item(id: 2, idLoja: 1, nome: "Cocar Indígena Extendido");
    Item item3 = new Item(id: 3, idLoja: 1, nome: "Lança Tupiniquim");

    Item item4 = new Item(id: 4, idLoja: 3, nome: "Colar de Madeira");
    Item item5 = new Item(id: 5, idLoja: 3, nome: "Colar de Pérolas");
    Item item6 = new Item(id: 6, idLoja: 3, nome: "Chapéu de Palha");

    itens.add(item1);
    itens.add(item2);
    itens.add(item3);
    itens.add(item4);
    itens.add(item5);
    itens.add(item6);
  }
}