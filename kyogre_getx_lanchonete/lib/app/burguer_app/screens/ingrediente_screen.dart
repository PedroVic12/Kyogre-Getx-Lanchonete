import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/app/burguer_app/entities/ingredientesModel.dart';

class IngredientesScreen extends StatefulWidget {
  const IngredientesScreen({Key? key}) : super(key: key);

  @override
  State<IngredientesScreen> createState() => _IngredientesScreenState();
}

class _IngredientesScreenState extends State<IngredientesScreen> {
  final burgerController = Get.put(BurgerController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        burgerController.ingredients.forEach((element) {
          burgerController.animateIngrediente(element);
        });
      });
    });
  }

  Future<void> onAddIngrediente(IngredientEntity ingredient) async {
    setState(() => burgerController.animateRemoveTopBun());
    await Future.delayed(const Duration(milliseconds: 500));

    setState(() => burgerController.addIngredient(ingredient));
    await Future.delayed(const Duration(milliseconds: 500));

    setState(() => burgerController.animateAddTopBun());
  }

  void onRemoveIngrediente(IngredientEntity ingredient) {
    setState(() => burgerController.removeIngrediente(ingredient));
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
                return ScaleTransition(scale: animation, child: child);
              },
              child: Text(
                "\$${burgerController.totalPreco}",
                key: ValueKey(burgerController.totalPreco),
                style: const TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    ...burgerController.ingredients.map(
                      (ingredient) => AnimatedPositioned(
                        duration: const Duration(milliseconds: 780),
                        curve: Curves.bounceOut,
                        bottom: ingredient.insertIntoBurger
                            ? burgerController.getIngredientesStackHeight(
                                ingredient.type + ingredient.offset.toString())
                            : 100,
                        child: Transform.scale(
                          scale:
                              ingredient.scale * burgerController.burgerScale,
                          child: Draggable(
                            feedback: Image.asset(
                              ingredient.path,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                            childWhenDragging: Container(),
                            data: ingredient,
                            child: Image.asset(
                              ingredient.path,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            CarouselIngredientsSelection(
              onAddIngrediente: onAddIngrediente,
              onRemoveIngrediente: onRemoveIngrediente,
            ),
          ],
        ),
      ),
    );
  }
}

class CarouselIngredientsSelection extends StatefulWidget {
  final void Function(IngredientEntity) onAddIngrediente;
  final void Function(IngredientEntity) onRemoveIngrediente;

  const CarouselIngredientsSelection({
    Key? key,
    required this.onAddIngrediente,
    required this.onRemoveIngrediente,
  }) : super(key: key);

  @override
  State<CarouselIngredientsSelection> createState() =>
      _CarouselIngredientsSelectionState();
}

class _CarouselIngredientsSelectionState
    extends State<CarouselIngredientsSelection> {
  late PageController pageController;
  num currentPage = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController(viewportFraction: 0.3)
      ..addListener(updateCurrentPage);
  }

  void updateCurrentPage() {
    if (pageController.page != null) {
      setState(() => currentPage = pageController.page!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final burgerController = Get.find<BurgerController>();
    final ingredients = burgerController.ingredients
        .where((e) => e.type != "bunBottom" && e.type != "bunTop")
        .toList();

    return Padding(
      padding: const EdgeInsets.all(6),
      child: SizedBox(
        height: 210,
        child: PageView.builder(
          controller: pageController,
          itemCount: ingredients.length,
          itemBuilder: (_, index) {
            final ingredient = ingredients[index];
            return Opacity(
              opacity: (1 / (((currentPage - index).abs() * 5) + 1)),
              child: Column(
                children: [
                  Text(ingredient.price.toString()),
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: Image.asset(
                      ingredient.path,
                      fit: BoxFit.cover,
                    ),
                  ),
                  if (index == currentPage.round())
                    AddRemoveIconsWidget(
                      onAdd: () => widget.onAddIngrediente(ingredient),
                      onRemove: () => widget.onRemoveIngrediente(ingredient),
                      isAddDisable:
                          burgerController.ingredientesInBurger(ingredient),
                      isRemoveDisable:
                          !burgerController.ingredientesInBurger(ingredient),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}

class AddRemoveIconsWidget extends StatelessWidget {
  final VoidCallback onAdd;
  final VoidCallback onRemove;
  final bool isAddDisable;
  final bool isRemoveDisable;

  const AddRemoveIconsWidget({
    Key? key,
    required this.onAdd,
    required this.onRemove,
    required this.isAddDisable,
    required this.isRemoveDisable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 200),
      builder: (context, opacity, child) {
        return Opacity(
          opacity: opacity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: isAddDisable ? null : onAdd,
              ),
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: isRemoveDisable ? null : onRemove,
              ),
            ],
          ),
        );
      },
    );
  }
}
