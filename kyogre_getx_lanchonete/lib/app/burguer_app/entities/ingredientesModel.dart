import 'package:get/get.dart';

class IngredientEntity {
  final String type;
  final double price;
  final String path;
  bool insertIntoBurger;
  final double height;

  IngredientEntity(
    this.height, {
    required this.type,
    required this.price,
    required this.path,
    this.insertIntoBurger = false,
  });
}

// Modelo Ingredientes
class Ingredientes {
  final String type;
  final double price;
  final String path;
  final double height;
  final bool insertIntBurger;
  final num offset;
  final double scale;
  final int max;

  Ingredientes({
    required this.type,
    required this.price,
    required this.path,
    required this.height,
    required this.insertIntBurger,
    required this.offset,
    required this.scale,
    required this.max,
  });
}

// Controlador GetX para gerenciar a lista de ingredientes
class IngredientesController extends GetxController {
  var ingredientesList = <Ingredientes>[
    Ingredientes(
      height: 30,
      type: 'picanha',
      price: 15.0,
      insertIntBurger: false,
      offset: 0,
      scale: 1,
      max: 1,
      path: 'assets/imagesBurguerApp/picanha.jpeg',
    ),
    Ingredientes(
      height: 20,
      type: 'queijo',
      price: 15.0,
      insertIntBurger: false,
      offset: -50,
      scale: 1,
      max: 5,
      path: 'assets/imagesBurguerApp/queijo.jpeg',
    ),
    Ingredientes(
      height: 50,
      type: 'tomate',
      price: -15.0,
      insertIntBurger: false,
      offset: 0,
      scale: 1,
      max: 1,
      path: 'assets/imagesBurguerApp/tomate.jpeg',
    ),
    Ingredientes(
      height: 45,
      type: 'picanha',
      price: 15.0,
      insertIntBurger: false,
      offset: 0,
      scale: 1,
      max: 1,
      path: 'assets/imagesBurguerApp/picanha.jpeg',
    ),
    Ingredientes(
      height: 45,
      type: 'bottom',
      price: 15.0,
      insertIntBurger: false,
      offset: 0,
      scale: 1,
      max: 1,
      path: 'assets/imagesBurguerApp/bottom.jpeg',
    ),
    Ingredientes(
      height: 45,
      type: 'top',
      price: 15.0,
      insertIntBurger: false,
      offset: 0,
      scale: 1,
      max: 1,
      path: 'assets/imagesBurguerApp/top.jpeg',
    ),
  ].obs;

  void toggleInsertIntBurger(int index) {
    ingredientesList[index] = Ingredientes(
      height: ingredientesList[index].height,
      type: ingredientesList[index].type,
      price: ingredientesList[index].price,
      insertIntBurger: !ingredientesList[index].insertIntBurger,
      offset: ingredientesList[index].offset,
      scale: ingredientesList[index].scale,
      max: ingredientesList[index].max,
      path: ingredientesList[index].path,
    );
    update();
  }
}
