class Productmodel {
  String nome;
  String categoria;
  String description;
  List<double> price;
  String image;

  Productmodel(
      {required this.nome,
      required this.categoria,
      required this.description,
      required this.price,
      required this.image});

  fromJson(Map<String, dynamic> json) {
    nome = json['name'];
    description = json['description'];
    price = json['price'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.nome;
    data['description'] = this.description;
    data['price_1'] = this.price[0];
    data['price_2'] = this.price[1];

    data['image'] = this.image;
    return data;
  }
}

List<Productmodel> getProdutos() {
  return [
    Productmodel(
        nome: 'X-Burguer',
        categoria: "Lanches",
        description: 'Pão, carne, queijo, alface, tomate, maionese',
        price: [10.0, 15.0],
        image: 'assets/images/burguer.jpg'),
    Productmodel(
        nome: 'X-Salada',
        categoria: "Lanches",
        description: 'Pão, carne, queijo, alface, tomate, maionese',
        price: [10.0, 15.0],
        image: 'assets/images/burguer.jpg'),
    Productmodel(
        nome: 'X-Bacon',
        categoria: "Lanches",
        description: 'Pão, carne, queijo, alface, tomate, maionese',
        price: [10.0, 15.0],
        image: 'assets/images/burguer.jpg'),
    Productmodel(
        nome: 'X-Tudo',
        categoria: "Lanches",
        description: 'Pão, carne, queijo, alface, tomate, maionese',
        price: [10.0, 15.0],
        image: 'assets/images/burguer.jpg'),
    Productmodel(
        nome: 'X-Egg',
        categoria: "Lanches",
        description: 'Pão, carne, queijo, alface, tomate, maionese',
        price: [10.0, 15.0],
        image: 'assets/images/burguer.jpg'),
    Productmodel(
        nome: 'X-Frango',
        categoria: "Lanches",
        description: 'Pão, carne, queijo, alface, tomate, maionese',
        price: [10.0, 15.0],
        image: 'assets/images/burguer.jpg'),
    Productmodel(
        nome: 'X-Calabresa',
        categoria: "Lanches",
        description: 'Pão, carne, queijo, alface, tomate, maionese',
        price: [10.0, 15.0],
        image: 'assets/images/burguer.jpg'),
    Productmodel(
        nome: 'X-Vegano',
        categoria: "Lanches",
        description: 'Pão, carne, queijo, alface, tomate, maionese',
        price: [10.0, 15.0],
        image: 'assets/images/burguer.jpg'),
  ];
}
