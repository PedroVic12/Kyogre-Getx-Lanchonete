import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/app/burguer_app/entities/ingredientesModel.dart';

//!https://www.youtube.com/watch?v=ztEr9Bu8Dkc&t=124s -- 11:00

// Controlador GetX para gerenciar a lista de ingredientes
class AppBurguerController extends GetxController {
  num burgerScale = 0.7;
  List<IngredientEntity> ingredients = <IngredientEntity>[];

  void init() {
    ingredients
      ..add(getIngredientByType("bunBottom") as IngredientEntity)
      ..add(getIngredientByType("bunTop") as IngredientEntity);
  }

  void adicionarIngrediente(IngredientEntity ingrediente) {
    ingrediente.insertIntBurger = true;
    ingredients.insert(ingredients.length - 1, ingrediente);
    animateIngrediente(ingrediente);
    update();
  }

  void removeIngrediente(IngredientEntity ingredienteType) {
    if (ingredients.isEmpty) {
      final index = ingredients
          .indexWhere((ingredient) => ingredient.type == ingredienteType.type);
      ingredients.removeAt(index);
    }
    ;

    update();
  }

  IngredientEntity getIngredientByType(String type) {
    // Encontra o ingrediente com base no tipo na lista pré-definida
    print(ingredients.firstWhere((ingredient) => ingredient.type == type));

    return ingredients.firstWhere((ingredient) => ingredient.type == type);
  }

  void animateAddTopBun() {
    if (ingredients.isNotEmpty) {
      animateIngrediente(ingredients[ingredients.length - 1]);

      ingredients[ingredients.length - 1].insertIntoBurger = true;
      update();
    }
  }

  void animateRemoveTopBun() {
    if (ingredients.isNotEmpty) {
      animateIngrediente(ingredients[ingredients.length - 1]);

      ingredients[ingredients.length - 1].insertIntoBurger = false;
      update();
    }
  }

  void addIngredient(IngredientEntity ingredient) {
    ingredient.insertIntoBurger = true;
    ingredients.insert(ingredients.length - 1, ingredient);
    update();
  }

  bool ingredientesInBurger(IngredientEntity ingredient) {
    return ingredients.any((e) => e.type == ingredient.type);
  }

  void animateIngrediente(IngredientEntity ingredientToAnimate) {
    //ingredient.insertIntoBurger = !ingredient.insertIntoBurger;
    var array = [];
    ingredients = ingredients.map((e) {
      if (e.type == ingredientToAnimate.type) {
        var tipo = ingredientToAnimate.insertIntoBurger =
            !ingredientToAnimate.insertIntoBurger;
        array.addAll(tipo as Iterable);
        print(array);
      }
      return e;
    }).toList();

    update();
  }

  num get totalPreco {
    return ingredients
        .map((ingrediente) => ingrediente.price)
        .reduce((a, b) => a + b);
  }

  int getNumberofIngredientes(IngredientEntity ingredient) {
    return ingredients.where((e) => e.type == ingredient.type).length;
  }

  double getIngredientesStackHeight(String ingredienteType) {
    double totalHeight = 0.0;

    final index = ingredients.indexWhere((ingredient) =>
        ingredient.type == ingredienteType && ingredient.insertIntoBurger);

    final copy = [...ingredients];

    copy.removeRange(index + 1, copy.length);

    for (final ingredient in copy) {
      totalHeight += ingredient.height * burgerScale;
    }

    return totalHeight;
  }
}
