class Produto {
  final int id;
  final String nome;
  final double preco;
  final String imageUrl;

  Produto({
    required this.id,
    required this.nome,
    required this.preco,
    required this.imageUrl,
  });

  static List<Produto> produtos_loja = [
    Produto(
      id: 1,
      nome: 'Sanduiches Naturais',
      preco: 7.99,
      imageUrl:
      'https://media.istockphoto.com/id/1309352410/pt/foto/cheeseburger-with-tomato-and-lettuce-on-wooden-board.jpg?s=1024x1024&w=is&k=20&c=zRrwnY2BdwaC5GgLFPcVNWedOPQ-0OVEkjqYzRx4jPQ=',
    ),
    Produto(
      id: 2,
      nome: 'Açai',
      preco: 12.75,
      imageUrl:
      'https://lh3.googleusercontent.com/p/AF1QipNC2D-Ggc3JYDp1W37zHGU5de2Rbmel2n7NLzlT=s1280-p-no-v1',
    ),
    Produto(
      id: 3,
      nome: 'Pizza',
      preco: 22.75,
      imageUrl:
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSknZTCwZ-A2i2zBfm21AEiFFcu2yCPOzPY5A&usqp=CAU',
    ),
  ];
}
