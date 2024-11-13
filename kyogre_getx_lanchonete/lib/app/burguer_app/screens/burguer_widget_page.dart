import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/app/burguer_app/entities/ingredientesModel.dart';

class BurgerApp extends StatelessWidget {
  const BurgerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.yellow,
      body: SafeArea(
        child: BurgerContent(),
      ),
    );
  }
}

class BurgerContent extends StatefulWidget {
  const BurgerContent({super.key});

  @override
  State<BurgerContent> createState() => _BurgerContentState();
}

class _BurgerContentState extends State<BurgerContent> {
  final burgerController = Get.put(BurgerController());

  @override
  void initState() {
    super.initState();
    burgerController.onInit();
    _initializeIngredients();
  }

  void _initializeIngredients() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      for (var ingredient in burgerController.ingredients) {
        burgerController.animateIngrediente(ingredient);
      }
    });
  }

  Future<void> _onAddIngredient(IngredientEntity ingredient) async {
    burgerController.animateTopBun(false);
    await Future.delayed(const Duration(milliseconds: 500));

    burgerController.adicionarIngrediente(ingredient);
    await Future.delayed(const Duration(milliseconds: 500));

    burgerController.animateTopBun(true);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const PriceDisplay(),
        const Expanded(child: BurgerStack()),
        IngredientsCarousel(
          onAddIngredient: _onAddIngredient,
          onRemoveIngredient: burgerController.removeIngrediente,
        ),
      ],
    );
  }
}

class PriceDisplay extends GetView<BurgerController> {
  const PriceDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder: (child, animation) {
            return ScaleTransition(scale: animation, child: child);
          },
          child: Text(
            "\$${controller.totalPreco}",
            key: ValueKey(controller.totalPreco),
            style: const TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
            ),
          ),
        ));
  }
}

class BurgerStack extends GetView<BurgerController> {
  const BurgerStack({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Obx(() => Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              for (var ingredient in controller.ingredients)
                BurgerIngredient(ingredient: ingredient),
            ],
          )),
    );
  }
}

class BurgerIngredient extends GetView<BurgerController> {
  final IngredientEntity ingredient;

  const BurgerIngredient({
    super.key,
    required this.ingredient,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 780),
      curve: Curves.bounceOut,
      bottom: ingredient.insertIntoBurger
          ? controller.getIngredientesStackHeight(
              ingredient.type + ingredient.offset.toString())
          : 100,
      child: Transform.scale(
        scale: ingredient.scale * controller.burgerScale,
        child: Draggable(
          feedback: IngredientImage(ingredient: ingredient),
          childWhenDragging: Container(),
          data: ingredient,
          child: IngredientImage(ingredient: ingredient),
        ),
      ),
    );
  }
}

class IngredientImage extends StatelessWidget {
  final IngredientEntity ingredient;

  const IngredientImage({
    super.key,
    required this.ingredient,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      ingredient.path,
      width: 50,
      height: 50,
      fit: BoxFit.cover,
    );
  }
}

class IngredientsCarousel extends GetView<BurgerController> {
  final void Function(IngredientEntity) onAddIngredient;
  final void Function(IngredientEntity) onRemoveIngredient;

  const IngredientsCarousel({
    super.key,
    required this.onAddIngredient,
    required this.onRemoveIngredient,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: SizedBox(
        height: 210,
        child: Obx(() => _CarouselContent(
              ingredients: controller.ingredients
                  .where((e) => e.type != "bunBottom" && e.type != "bunTop")
                  .toList(),
              onAddIngredient: onAddIngredient,
              onRemoveIngredient: onRemoveIngredient,
            )),
      ),
    );
  }
}

class _CarouselContent extends GetView<BurgerController> {
  final List<IngredientEntity> ingredients;
  final void Function(IngredientEntity) onAddIngredient;
  final void Function(IngredientEntity) onRemoveIngredient;

  _CarouselContent({
    required this.ingredients,
    required this.onAddIngredient,
    required this.onRemoveIngredient,
  });

  final _currentPage = 0.0.obs;
  final _pageController = PageController(viewportFraction: 0.3);

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      itemCount: ingredients.length,
      onPageChanged: (page) => _currentPage.value = page.toDouble(),
      itemBuilder: (_, index) {
        final ingredient = ingredients[index];
        return Obx(() => Opacity(
              opacity: _getOpacity(index),
              child: IngredientCard(
                ingredient: ingredient,
                isSelected: index == _currentPage.value.round(),
                onAdd: () => onAddIngredient(ingredient),
                onRemove: () => onRemoveIngredient(ingredient),
              ),
            ));
      },
    );
  }

  double _getOpacity(int index) {
    return 1 / (((_currentPage.value - index).abs() * 5) + 1);
  }
}

class IngredientCard extends GetView<BurgerController> {
  final IngredientEntity ingredient;
  final bool isSelected;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  const IngredientCard({
    super.key,
    required this.ingredient,
    required this.isSelected,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(ingredient.price.toString()),
        SizedBox(
          width: 100,
          height: 100,
          child: IngredientImage(ingredient: ingredient),
        ),
        if (isSelected)
          AddRemoveButtons(
            onAdd: onAdd,
            onRemove: onRemove,
            isAddDisabled: controller.ingredientesInBurger(ingredient),
            isRemoveDisabled: !controller.ingredientesInBurger(ingredient),
          ),
      ],
    );
  }
}

class AddRemoveButtons extends StatelessWidget {
  final VoidCallback onAdd;
  final VoidCallback onRemove;
  final bool isAddDisabled;
  final bool isRemoveDisabled;

  const AddRemoveButtons({
    super.key,
    required this.onAdd,
    required this.onRemove,
    required this.isAddDisabled,
    required this.isRemoveDisabled,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 200),
      builder: (context, opacity, _) {
        return Opacity(
          opacity: opacity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: isAddDisabled ? null : onAdd,
              ),
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: isRemoveDisabled ? null : onRemove,
              ),
            ],
          ),
        );
      },
    );
  }
}
