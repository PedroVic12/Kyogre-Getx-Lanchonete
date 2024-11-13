import 'package:get/get.dart';

// Modelo Ingredientes
// Ingredient Model
class IngredientEntity {
  final String type;
  final double price;
  final String path;
  final double height;
  bool insertIntoBurger;
  final num offset;
  final double scale;
  final int max;

  IngredientEntity({
    required this.type,
    required this.price,
    required this.path,
    required this.height,
    required this.insertIntoBurger,
    required this.offset,
    required this.scale,
    required this.max,
  });

  set insertIntBurger(bool insertIntBurger) {}

  void toggleInsert() {
    insertIntoBurger = !insertIntoBurger;
  }
}

// Burger Controller using GetX
class BurgerController extends GetxController {
  final ingredients = <IngredientEntity>[].obs;
  double burgerScale = 1.0;
  double totalPreco = 0.0;

  void adicionarIngrediente(IngredientEntity ingrediente) {
    ingrediente.insertIntBurger = true;
    ingredients.insert(ingredients.length - 1, ingrediente);
    animateIngrediente(ingrediente);
    update();
  }

  void init() {
    ingredients.addAll([
      IngredientEntity(
        height: 30,
        type: 'picanha',
        price: 15.0,
        insertIntoBurger: false,
        offset: 0,
        scale: 1,
        max: 1,
        path: 'assets/assets_burguer_app/picanha.png',
      ),
      IngredientEntity(
        height: 20,
        type: 'queijo',
        price: 15.0,
        insertIntoBurger: false,
        offset: -50,
        scale: 1,
        max: 5,
        path: 'assets/assets_burguer_app/queijo.png',
      ),
      IngredientEntity(
        height: 50,
        type: 'tomate',
        price: -15.0,
        insertIntoBurger: false,
        offset: 0,
        scale: 1,
        max: 1,
        path: 'assets/assets_burguer_app/tomate.png',
      ),
      IngredientEntity(
        height: 45,
        type: 'picanha',
        price: 15.0,
        insertIntoBurger: false,
        offset: 0,
        scale: 1,
        max: 1,
        path: 'assets/assets_burguer_app/picanha.png',
      ),
      IngredientEntity(
        height: 45,
        type: 'bunBottom',
        price: 15.0,
        insertIntoBurger: false,
        offset: 0,
        scale: 1,
        max: 1,
        path: 'assets/assets_burguer_app/bottom.png',
      ),
      IngredientEntity(
        height: 45,
        type: 'bunTop',
        price: 15.0,
        insertIntoBurger: false,
        offset: 0,
        scale: 1,
        max: 1,
        path: 'assets/assets_burguer_app/top-burguer.png',
      ),
    ]);
    calculateTotal();
  }

  void animateIngrediente(IngredientEntity ingredient) {
    ingredient.insertIntoBurger = true;
    update();
  }

  void animateTopBun(bool bool) {
    if (ingredients.isNotEmpty) {
      animateIngrediente(ingredients[ingredients.length - 1]);

      ingredients[ingredients.length - 1].insertIntoBurger = true;
      update();
    }
  }

  void animateAddTopBun() {
    final topBun = ingredients.firstWhere((e) => e.type == 'bunTop');
    topBun.insertIntoBurger = true;
    update();
  }

  void animateRemoveTopBun() {
    final topBun = ingredients.firstWhere((e) => e.type == 'bunTop');
    topBun.insertIntoBurger = false;
    update();
  }

  double getIngredientesStackHeight(dynamic type) {
    double height = 0;
    for (var ingredient in ingredients.where((e) => e.insertIntoBurger)) {
      height += ingredient.height;
    }
    return height;
  }

  void addIngredient(IngredientEntity ingredient) {
    if (!ingredientesInBurger(ingredient)) {
      ingredients.add(ingredient.copyWith(insertIntoBurger: true));
      calculateTotal();
      update();
    }
  }

  void removeIngrediente(IngredientEntity ingredient) {
    ingredients
        .removeWhere((e) => e.type == ingredient.type && e.insertIntoBurger);
    calculateTotal();
    update();
  }

  bool ingredientesInBurger(IngredientEntity ingredient) {
    return ingredients
            .where((e) => e.type == ingredient.type && e.insertIntoBurger)
            .length >=
        ingredient.max;
  }

  void calculateTotal() {
    totalPreco = ingredients
        .where((e) => e.insertIntoBurger)
        .fold(0, (sum, item) => sum + item.price);
  }
}

extension IngredientEntityExtension on IngredientEntity {
  IngredientEntity copyWith({
    String? type,
    double? price,
    String? path,
    double? height,
    bool? insertIntoBurger,
    num? offset,
    double? scale,
    int? max,
  }) {
    return IngredientEntity(
      type: type ?? this.type,
      price: price ?? this.price,
      path: path ?? this.path,
      height: height ?? this.height,
      insertIntoBurger: insertIntoBurger ?? this.insertIntoBurger,
      offset: offset ?? this.offset,
      scale: scale ?? this.scale,
      max: max ?? this.max,
    );
  }
}

// Controlador GetX para gerenciar a lista de ingredientes
class IngredientesController extends GetxController {
  var ingredientesList = <IngredientEntity>[
    IngredientEntity(
      height: 30,
      type: 'picanha',
      price: 15.0,
      insertIntoBurger: false,
      offset: 0,
      scale: 1,
      max: 1,
      path: 'assets/assets_burguer_app/picanha.png',
    ),
    IngredientEntity(
      height: 20,
      type: 'queijo',
      price: 15.0,
      insertIntoBurger: false,
      offset: -50,
      scale: 1,
      max: 5,
      path: 'assets/assets_burguer_app/queijo.png',
    ),
    IngredientEntity(
      height: 50,
      type: 'tomate',
      price: -15.0,
      insertIntoBurger: false,
      offset: 0,
      scale: 1,
      max: 1,
      path: 'assets/assets_burguer_app/tomate.png',
    ),
    IngredientEntity(
      height: 45,
      type: 'picanha',
      price: 15.0,
      insertIntoBurger: false,
      offset: 0,
      scale: 1,
      max: 1,
      path: 'assets/assets_burguer_app/picanha.png',
    ),
    IngredientEntity(
      height: 45,
      type: 'bunBottom',
      price: 15.0,
      insertIntoBurger: false,
      offset: 0,
      scale: 1,
      max: 1,
      path: 'assets/assets_burguer_app/bottom.png',
    ),
    IngredientEntity(
      height: 45,
      type: 'bunTop',
      price: 15.0,
      insertIntoBurger: false,
      offset: 0,
      scale: 1,
      max: 1,
      path: 'assets/assets_burguer_app/top-burguer.png',
    ),
  ].obs;

  void toggleInsertIntBurger(int index) {
    ingredientesList[index] = IngredientEntity(
      height: ingredientesList[index].height,
      type: ingredientesList[index].type,
      price: ingredientesList[index].price,
      insertIntoBurger: !ingredientesList[index].insertIntoBurger,
      offset: ingredientesList[index].offset,
      scale: ingredientesList[index].scale,
      max: ingredientesList[index].max,
      path: ingredientesList[index].path,
    );
    update();
  }
}
