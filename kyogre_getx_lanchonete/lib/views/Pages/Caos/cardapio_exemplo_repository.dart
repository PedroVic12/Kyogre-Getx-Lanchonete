class Product {
  final String name;
  final String description;
  final double price;

  Product({
    required this.name,
    required this.description,
    required this.price,
  });
}

class ProductRepository {
  List<Product> getPizzas() {
    return [
      Product(
          name: 'Margherita',
          description: 'Tomato, mozzarella, basil',
          price: 12.00),
      Product(
          name: 'Pepperoni',
          description: 'Pepperoni, mozzarella, tomato',
          price: 14.00),
      Product(
          name: 'BBQ Chicken',
          description: 'BBQ sauce, chicken, onions',
          price: 15.00),
      Product(
          name: 'Vegetarian',
          description: 'Assorted vegetables, mozzarella',
          price: 13.00),
      Product(
          name: 'Hawaiian',
          description: 'Ham, pineapple, cheese',
          price: 14.00),
    ];
  }

  List<Product> getSandwiches() {
    return [
      Product(
          name: 'BLT',
          description: 'Bacon, lettuce, tomato, mayo',
          price: 8.00),
      Product(
          name: 'Turkey Club',
          description: 'Turkey, bacon, lettuce, tomato',
          price: 9.00),
      Product(
          name: 'Grilled Cheese',
          description: 'Cheddar cheese, grilled bread',
          price: 7.00),
      Product(
          name: 'Ham & Cheese', description: 'Ham, cheese, bread', price: 8.00),
      Product(
          name: 'Veggie',
          description: 'Assorted vegetables, cheese',
          price: 8.00),
    ];
  }

  List<Product> getJuices() {
    return [
      Product(
          name: 'Orange Juice',
          description: 'Freshly squeezed orange juice',
          price: 5.00),
      Product(
          name: 'Apple Juice', description: '100% apple juice', price: 4.50),
      Product(
          name: 'Carrot Juice',
          description: 'Freshly squeezed carrot juice',
          price: 5.00),
      Product(
          name: 'Grapefruit Juice',
          description: 'Freshly squeezed grapefruit juice',
          price: 5.50),
      Product(
          name: 'Mixed Fruit Juice',
          description: 'Blend of various fruits',
          price: 6.00),
    ];
  }

  List<Product> getCoffees() {
    return [
      Product(
          name: 'Espresso', description: 'Strong black coffee', price: 3.00),
      Product(
          name: 'Latte',
          description: 'Espresso with steamed milk',
          price: 4.00),
      Product(
          name: 'Cappuccino',
          description: 'Espresso with frothy milk',
          price: 4.50),
      Product(
          name: 'Americano',
          description: 'Espresso with hot water',
          price: 3.50),
      Product(
          name: 'Mocha',
          description: 'Espresso with chocolate and milk',
          price: 5.00),
    ];
  }
}
