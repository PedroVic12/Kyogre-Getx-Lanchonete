import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:better_page_turn/better_page_turn.dart';

// Your imports
import 'package:kyogre_getx_lanchonete/app/widgets/Custom/CustomText.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Caos/tab_nav_cardapio.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Tela%20Cardapio%20Digital/CardapioScreenLayout/animated_cardapio_glass.dart';

class NewCardapioDigital2024 extends StatefulWidget {
  const NewCardapioDigital2024({super.key});

  @override
  State<NewCardapioDigital2024> createState() => _NewCardapioDigital2024State();
}

class _NewCardapioDigital2024State extends State<NewCardapioDigital2024>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentIndex = 0;

  HorizontalFlipPageTurnController horizontalFlipPageTurnController =
      HorizontalFlipPageTurnController();

  GlobalKey<CartIconKey> cartKey = GlobalKey<CartIconKey>();
  late Function(GlobalKey) runAddToCartAnimation;
  var _cartQuantityItems = 0;

  double _appBarHeight = 180.0; // Initial app bar height

  void _handleTabSelection() {
    if (!_tabController.indexIsChanging) {
      setState(() {
        _currentIndex = _tabController.index;
        // Animate the page turn to the corresponding tab index

        horizontalFlipPageTurnController.animToPositionWidget(_currentIndex,
            duration: const Duration(milliseconds: 350));
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
    super.dispose();
  }

  void listClick(GlobalKey widgetKey) async {
    await runAddToCartAnimation(widgetKey);
    await cartKey.currentState!
        .runCartAnimation((++_cartQuantityItems).toString());

    // Adjust app bar height on scroll
    setState(() {
      _appBarHeight = 150.0; // Reduced height when scrolled
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
            middle: Row(
          children: [
            Text('Digital Menu'),
            IconButton(
              icon: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: Colors.red, width: 3, style: BorderStyle.solid),
                  // borderRadius: BorderRadius.circular(50),
                ),
                child: const Icon(
                  Icons.clear,

                  color: Colors.red,
                  size: 36, // Reduced icon size
                ),
              ),
              onPressed: () {
                _cartQuantityItems = 0;

                cartKey.currentState!.runClearCartAnimation();
              },
            ),

            const SizedBox(width: 8), // Reduced spacing
            AddToCartIcon(
              key: cartKey,
              icon: const Icon(
                Icons.shopping_cart,
                color: Colors.green,
                size: 50, // Reduced icon size
              ),
              badgeOptions: const BadgeOptions(
                active: true,
                backgroundColor: Colors.red,
              ),
            ),
            const SizedBox(width: 32),
            Icon(Icons.fastfood),
          ],
        )),
        child: ListView(
          children: [
            Container(
              height: 100,
              color: CupertinoColors.systemYellow,
              child: TabBar(
                isScrollable: true,
                enableFeedback: true,
                automaticIndicatorColorAdjustment: true,
                padding: const EdgeInsets.all(10),
                controller: _tabController,
                tabs: [
                  _buildTabItem(Icons.local_pizza, 'Pizzas', 0),
                  _buildTabItem(Icons.info, 'Sandwiches', 1),
                  _buildTabItem(Icons.local_drink, 'Juices', 2),
                  _buildTabItem(Icons.coffee, 'Coffees', 3),
                ],
              ),
            ),
            LayoutBuilder(builder: (context, constraints) {
              return HorizontalFlipPageTurn(
                children: [
                  //_buildProductList(ProductRepository().getPizzas()),

                  buildCardGlass(),
                  _buildProductList(ProductRepository().getSandwiches()),
                  _buildProductList(ProductRepository().getJuices()),
                  _buildProductList(ProductRepository().getCoffees()),
                ],
                cellSize: Size(constraints.maxWidth, 600),
                controller: horizontalFlipPageTurnController,
              );
            }),
            //StoragePhotosWidger(),
          ],
        ),
      ),
    );
  }

  // Helper function to build each tab item
  Widget _buildTabItem(IconData icon, String label, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          //horizontalFlipPageTurnController.animToPositionWidget(index);

          _tabController.animateTo(index);
        });
      },
      child: Container(
        height: 100,
        width: 130,
        decoration: BoxDecoration(
          color: Colors.blueGrey.shade50,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 30),
            const SizedBox(height: 5),
            CustomText(text: label, size: 16),
          ],
        ),
      ),
    );
  }

  // Function to build the product list for each category
  Widget _buildProductList(List<Product> products) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return Card(
          child: ListTile(
            leading: const Icon(Icons.fastfood),
            title: Text(product.name),
            subtitle: Text(product.description),
            trailing: Text('\$${product.price.toStringAsFixed(2)}'),
          ),
        );
      },
    );
  }

  Widget buildCardGlass() {
    return AddToCartAnimation(
      cartKey: cartKey,
      height: 120,
      width: 120,
      opacity: 0.85,
      dragAnimation: const DragToCartAnimationOptions(
        curve: Curves.easeInExpo,
        rotation: true,
      ),
      jumpAnimation: const JumpAnimationOptions(),
      createAddToCartAnimation: (runAddToCartAnimation) {
        this.runAddToCartAnimation = runAddToCartAnimation;
      },
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 7, 20, 92),
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                backgroundColor: Colors.black,
                expandedHeight: _appBarHeight,
                pinned: true, // Keep the app bar pinned
                flexibleSpace: FlexibleSpaceBar(
                  title: CustomText(
                    text: "Ruby Delivery",
                    size: 24,
                    color: Colors.white,
                    weight: FontWeight.bold,
                  ),
                  centerTitle: true,
                  background: Image.asset(
                    "assets/logo_ruby.png",
                    fit: BoxFit.cover,
                  ),
                ),
                centerTitle: true,
                actions: [
                  IconButton(
                    icon: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: Colors.red,
                            width: 3,
                            style: BorderStyle.solid),
                        // borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Icon(
                        Icons.clear,

                        color: Colors.red,
                        size: 36, // Reduced icon size
                      ),
                    ),
                    onPressed: () {
                      _cartQuantityItems = 0;

                      cartKey.currentState!.runClearCartAnimation();
                    },
                  ),
                  // TextButton(
                  //     onPressed: () {
                  //       _cartQuantityItems = 0;

                  //       cartKey.currentState!.runClearCartAnimation();
                  //     },
                  //     child: const Text("Limpar Sacola")),

                  const SizedBox(width: 8), // Reduced spacing
                  AddToCartIcon(
                    key: cartKey,
                    icon: const Icon(
                      Icons.shopping_cart,
                      color: Colors.green,
                      size: 50, // Reduced icon size
                    ),
                    badgeOptions: const BadgeOptions(
                      active: true,
                      backgroundColor: Colors.red,
                    ),
                  ),
                  const SizedBox(width: 32),
                ],
              ),
            ];
          },
          body: ListView(
              scrollDirection: Axis.vertical,
              dragStartBehavior: DragStartBehavior.start,
              children: List.generate(
                15,
                (index) => Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: GlassMorphism(
                    //glass opacity and blur
                    //showBoxShadow: false,
                    //showGradient: false,
                    //opacity: 0.3,

                    blur: 8000,
                    color: Colors.blueGrey.shade400,
                    borderRadius: BorderRadius.circular(12),
                    child: AppListItem(
                      onClick: listClick,
                      index: index,
                    ),
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
