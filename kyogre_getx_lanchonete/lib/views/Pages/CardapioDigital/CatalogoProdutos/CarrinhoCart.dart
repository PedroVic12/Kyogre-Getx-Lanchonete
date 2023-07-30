import 'package:flutter/material.dart';
import 'package:kyogre_getx_lanchonete/models/Produtos/products_model.dart';

class ShoppingCart extends StatefulWidget {
  const ShoppingCart({Key? key}) : super(key: key);

  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  List<ShoppingCartItem> cartItems = [];

  void addToCart(ShoppingCartItem item) {
    setState(() {
      final existingItemIndex = cartItems
          .indexWhere((cartItem) => cartItem.produto.id == item.produto.id);
      if (existingItemIndex != -1) {
        cartItems[existingItemIndex].quantity++;
      } else {
        cartItems.add(item);
      }
    });
  }

  void removeFromCart(ShoppingCartItem item) {
    setState(() {
      final existingItemIndex = cartItems
          .indexWhere((cartItem) => cartItem.produto.id == item.produto.id);
      if (existingItemIndex != -1) {
        cartItems[existingItemIndex].quantity--;
        if (cartItems[existingItemIndex].quantity == 0) {
          cartItems.removeAt(existingItemIndex);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Shopping Cart')),
      body: ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          final item = cartItems[index];
          return ListTile(
            leading: CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(item.produto.imageUrl),
            ),
            title: Text(item.produto.nome),
            subtitle: Text('${item.produto.preco}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () => removeFromCart(item),
                  icon: Icon(Icons.remove),
                ),
                Text(item.quantity.toString()),
                IconButton(
                  onPressed: () => addToCart(item),
                  icon: Icon(Icons.add),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ShoppingCartItem {
  final Produto produto;
  int quantity;

  ShoppingCartItem({required this.produto, this.quantity = 1});
}

class ShoppingCart extends StatefulWidget {
  const ShoppingCart({Key? key}) : super(key: key);

  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  List<ShoppingCartItem> cartItems = [];

  void addToCart(ShoppingCartItem item) {
    setState(() {
      var id;
      final existingItemIndex = cartItems
          .indexWhere((cartItem) => cartItem.produto.id == item.produto.id);
      if (existingItemIndex != -1) {
        cartItems[existingItemIndex].quantity++;
      } else {
        cartItems.add(item);
      }
    });
  }

  void removeFromCart(ShoppingCartItem item) {
    setState(() {
      final existingItemIndex = cartItems
          .indexWhere((cartItem) => cartItem.produto.id == item.produto.id);
      if (existingItemIndex != -1) {
        cartItems[existingItemIndex].quantity--;
        if (cartItems[existingItemIndex].quantity == 0) {
          cartItems.removeAt(existingItemIndex);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Shopping Cart')),
      body: ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          final item = cartItems[index];
          return ListTile(
            leading: CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(item.produto.imageUrl),
            ),
            title: Text(item.produto.nome),
            subtitle: Text('${item.produto.preco}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () => removeFromCart(item),
                  icon: Icon(Icons.remove),
                ),
                Text(item.quantity.toString()),
                IconButton(
                  onPressed: () => addToCart(item),
                  icon: Icon(Icons.add),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
