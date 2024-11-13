import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/app/burguer_app/entities/ingredientesModel.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Custom/CustomText.dart';

//!https://www.youtube.com/watch?v=ztEr9Bu8Dkc&t=124s -- 11:00

// Controlador GetX para gerenciar a lista de ingredientes
class BurgerController extends GetxController {
  num burgerScale = 0.7;
  List<IngredientEntity> ingredients = <IngredientEntity>[];

  void init() {
    ingredients
      ..add(getIngredientByType("bunBottom"))
      ..add(getIngredientByType("bunTop"));
  }

  void adicionarIngrediente(IngredientEntity ingrediente) {
    ingrediente.insertIntoBurger = true;
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
    print(predefinedIngredientsList
        .firstWhere((ingredient) => ingredient.type == type));

    return predefinedIngredientsList
        .firstWhere((ingredient) => ingredient.type == type);
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

//todo -> ver o video no minuto 26:22 com a pagina
class IngredientesScreen extends StatefulWidget {
  const IngredientesScreen({super.key});

  @override
  State<IngredientesScreen> createState() => _IngredientesScreenState();
}

final burguerControll = Get.put(BurgerController()..init());

class _IngredientesScreenState extends State<IngredientesScreen> {
  bool animate = false;

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        burguerControll.ingredients.forEach((element) {
          burguerControll.animateIngrediente(element);
        });
      });
    });

    super.initState;
  }

  void onAddIngrediente(IngredientEntity ingrediente) async {
    setState(() {
      burguerControll.animateRemoveTopBun();
    });
    await Future.delayed(
      const Duration(milliseconds: 500),
    );

    setState(() {
      burguerControll.addIngredient(ingrediente);
    });
    await Future.delayed(
      const Duration(milliseconds: 500),
    );
    setState(() {
      burguerControll.animateAddTopBun();
    });
  }

  void onRemoveIngrediente(IngredientEntity ingrediente) async {
    setState(() {
      burguerControll.removeIngrediente(ingrediente);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.yellow,
        body: SafeArea(
          child: Column(
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                transitionBuilder: (child, animation) {
                  return ScaleTransition(
                    scale: animation,
                    child: child,
                  );
                },
                child: Text(
                  "\$${burguerControll.totalPreco}",
                  key: ValueKey(burguerControll.totalPreco),
                  style: const TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              //Expanded
              Expanded(
                child: Center(
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      ...burguerControll.ingredients.map(
                        (ingredient) => AnimatedPositioned(
                          duration: const Duration(milliseconds: 780),
                          curve: Curves.bounceOut,
                          bottom: ingredient.insertIntoBurger
                              ? burguerControll
                                  .getIngredientesStackHeight(ingredient.type)
                              : 0,
                          top: burguerControll
                              .getIngredientesStackHeight(ingredient.type),
                          child: Draggable(
                            feedback: Image.asset(ingredient.path,
                                width: 50, height: 50, fit: BoxFit.cover),
                            childWhenDragging: Container(),
                            data: ingredient,
                            child: Image.asset(ingredient.path,
                                width: 50, height: 50, fit: BoxFit.cover),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

// Lista de ingredientes pré-definida para exemplo
final predefinedIngredientsList = <IngredientEntity>[
  IngredientEntity(
    type: "bunBottom",
    price: 0.5,
    path: "assets/imagesBurguerApp/bottom.jpeg",
  ),
  IngredientEntity(
      type: "bunTop", price: 0.5, path: "assets/imagesBurguerApp/top.jpeg"),
  IngredientEntity(
      type: "cheese", price: 0.5, path: "assets/imagesBurguerApp/cheese.jpeg"),
  IngredientEntity(
      type: "tomato", price: 0.4, path: "assets/imagesBurguerApp/tomato.jpeg"),
  IngredientEntity(
      type: "picanha",
      price: 1.5,
      path: "assets/imagesBurguerApp/picanha.jpeg"),
];

// Widget principal
class IngredientesListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Instancia o controlador
    final IngredientesController controller = Get.put(IngredientesController());

    return Scaffold(
      appBar: AppBar(
        title: Text("Ingredientes"),
      ),
      body: GetBuilder<IngredientesController>(
        builder: (_) {
          return ListView.builder(
            itemCount: controller.ingredientesList.length,
            itemBuilder: (context, index) {
              final ingrediente = controller.ingredientesList[index];
              return ListTile(
                leading: Image.asset(
                  ingrediente.path,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
                title: Text(ingrediente.type),
                subtitle: Text("Preço: \$${ingrediente.price}"),
                trailing: IconButton(
                  icon: Icon(
                    ingrediente.insertIntBurger
                        ? Icons.check_box
                        : Icons.check_box_outline_blank,
                  ),
                  onPressed: () {
                    controller.toggleInsertIntBurger(index);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
