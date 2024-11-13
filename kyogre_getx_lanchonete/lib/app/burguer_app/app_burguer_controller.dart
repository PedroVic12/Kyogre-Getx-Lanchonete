import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/app/burguer_app/entities/ingredientesModel.dart';

class BurguerController extends GetxController {
  static const double DEFAULT_BURGER_SCALE = 0.7;

  final double burgerScale;
  final RxList<IngredientEntity> ingredients = <IngredientEntity>[].obs;

  BurguerController({this.burgerScale = DEFAULT_BURGER_SCALE});

  @override
  void onInit() {
    super.onInit();
    _initializeBurger();
  }

  void _initializeBurger() {
    ingredients
      ..add(getIngredientByType("bunBottom"))
      ..add(getIngredientByType("bunTop"));
  }

  void adicionarIngrediente(IngredientEntity ingrediente) {
    if (ingrediente.type == "bunTop" || ingrediente.type == "bunBottom") return;

    final newIngredient = ingrediente.copyWith(insertIntoBurger: true);
    // Insert before the top bun
    ingredients.insert(ingredients.length - 1, newIngredient);
    animateIngrediente(newIngredient);
  }

  void removeIngrediente(IngredientEntity ingrediente) {
    if (ingredients.isEmpty) return;
    if (ingrediente.type == "bunTop" || ingrediente.type == "bunBottom") return;

    final index =
        ingredients.indexWhere((item) => item.type == ingrediente.type);
    if (index != -1) {
      ingredients.removeAt(index);
    }
  }

  IngredientEntity getIngredientByType(String type) {
    try {
      return ingredients.firstWhere(
        (ingredient) => ingredient.type == type,
      );
    } catch (e) {
      throw Exception('Ingredient type $type not found');
    }
  }

  void animateTopBun(bool insert) {
    if (ingredients.isEmpty) return;

    final topBun = ingredients.last;
    if (topBun.type != "bunTop") return;

    animateIngrediente(topBun);
    topBun.insertIntoBurger = insert;
  }

  bool ingredientesInBurger(IngredientEntity ingredient) {
    return ingredients.any((e) => e.type == ingredient.type);
  }

  void animateIngrediente(IngredientEntity ingredient) {
    final index = ingredients.indexWhere((e) => e.type == ingredient.type);
    if (index == -1) return;

    ingredients[index] = ingredient.copyWith(
      insertIntoBurger: !ingredient.insertIntoBurger,
    );
  }

  double get totalPreco {
    if (ingredients.isEmpty) return 0.0;
    return ingredients.fold(0.0, (sum, item) => sum + item.price);
  }

  int getNumberofIngredientes(IngredientEntity ingredient) {
    return ingredients.where((e) => e.type == ingredient.type).length;
  }

  double getIngredientesStackHeight(String ingredienteType) {
    final index = ingredients.indexWhere(
      (ingredient) =>
          ingredient.type == ingredienteType && ingredient.insertIntoBurger,
    );

    if (index == -1) return 0.0;

    return ingredients
        .sublist(0, index + 1)
        .fold(0.0, (sum, ingredient) => sum + ingredient.height * burgerScale);
  }
}
