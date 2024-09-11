import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:better_page_turn/horizontal_flip_page_turn.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:kyogre_getx_lanchonete/app/widgets/Custom/CustomText.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Caos/cardapio_exemplo_repository.dart';

class MyCardapioWidget extends StatefulWidget {
  const MyCardapioWidget({super.key});

  @override
  State<MyCardapioWidget> createState() => _MyCardapioWidgetState();
}

class _MyCardapioWidgetState extends State<MyCardapioWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentIndex = 0;

  HorizontalFlipPageTurnController horizontalFlipPageTurnController =
      HorizontalFlipPageTurnController();

  GlobalKey<CartIconKey> cartKey = GlobalKey<CartIconKey>();
  late Function(GlobalKey) runAddToCartAnimation;
  var _cartQuantityItems = 0;

  double _appBarHeight = 150.0; // Initial app bar height

  @override
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

  Widget build(BuildContext context) {
    return AddToCartAnimation(
      cartKey: cartKey,
      height: 100,
      width: 100,
      opacity: 0.80,
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
                    text: "Cardápio Digital",
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
                    icon: IconButton(
                      iconSize: 50,
                      icon: const Icon(Icons.shopping_cart),
                      onPressed: () {
                        _showCartBottomSheet();
                      },
                      color: Colors.green,
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
                      //_
                      _buildProductList(ProductRepository().getSandwiches()),
                      _buildProductList(ProductRepository().getJuices()),
                      _buildProductList(ProductRepository().getCoffees()),
                    ],
                    cellSize: Size(constraints.maxWidth, 300),
                    controller: horizontalFlipPageTurnController,
                  );
                }),
                for (int index = 0; index < 3; index++)
                  Padding(
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

                      // CardGlassList(
                      //     onClick: listClick,
                      //     index: index,
                      //     products: ProductRepository().getSandwiches())

                      //GlassCard(ProductRepository().getPizzas()),
                    ),
                  ),
              ]

              // List.generate(
              //   15,
              //   (index) =>
              // ),

              ),
        ),
      ),
    );
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

  Widget GlassCard(List<Product> products) {
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

  void _showCartBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allow the sheet to be full height
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Wrap(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total Items:', style: TextStyle(fontSize: 20)),
                  Text('$_cartQuantityItems',
                      style: const TextStyle(fontSize: 20)),
                ],
              ),
              const SizedBox(height: 16),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Total Price:', style: TextStyle(fontSize: 20)),
                  Divider(),
                  Text('R\$ 1500,00 reais', style: TextStyle(fontSize: 20)),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Handle checkout logic here
                  Navigator.pop(context); // Close the bottom sheet
                },
                child: const Text('Checkout'),
              ),
            ],
          ),
        );
      },
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
}

class CardGlassList extends StatelessWidget {
  final GlobalKey widgetKey = GlobalKey();
  final int index;
  final void Function(GlobalKey) onClick;
  final List<Product>? products;

  CardGlassList(
      {super.key,
      required this.onClick,
      required this.index,
      required this.products});

  @override
  Widget build(BuildContext context) {
    Container mandatoryContainer = Container(
      key: widgetKey,
      width: 150,
      height: 150,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 1),
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.blue,
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              blurRadius: 9.0,
            ),
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
              backgroundImage: AssetImage("assets/logo_ruby.png"),
              maxRadius: 50,
              child: Container()),
          const CustomText(
            text: "R\$ 1.050,00 Reais",
            color: Colors.white,
            size: 16,
          ),
        ],
      ),
    );

    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: products?.length,
      itemBuilder: (context, index) {
        final product = products![index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: CupertinoListTile(
            // backgroundColor: Colors.blueGrey.shade300,
            leadingSize: 150,
            // onTap: () => onClick(widgetKey),
            leading: mandatoryContainer,
            subtitle: Wrap(
              direction: Axis.vertical,
              alignment: WrapAlignment.center,
              textDirection: TextDirection.rtl,
              runAlignment: WrapAlignment.center,
              runSpacing: 10,
              verticalDirection: VerticalDirection.down,

              children: [
                Text(
                  product.description,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ],
              //"Animated Apple Product Image $index",
            ),

            trailing: FloatingActionButton.large(
              elevation: 7,
              hoverColor: Colors.green,
              backgroundColor: Colors.white,
              onPressed: () {
                onClick(widgetKey);
              },
              child: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.grey.shade300,
                child: Icon(
                  Icons.add,
                  color: Colors.green,
                  size: 60,
                ),
              ),
            ),
            title: CustomText(
              text: product.name,
              size: 24,
              weight: FontWeight.bold,
            ),
          ),
        );
      },
    );
  }
}

class AppListItem extends StatelessWidget {
  final GlobalKey widgetKey = GlobalKey();
  final int index;
  final void Function(GlobalKey) onClick;

  AppListItem({super.key, required this.onClick, required this.index});

  @override
  Widget build(BuildContext context) {
    Container mandatoryContainer = Container(
      key: widgetKey,
      width: 150,
      height: 150,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 1),
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.blue,
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              blurRadius: 9.0,
            ),
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
              backgroundImage: AssetImage("assets/logo_ruby.png"),
              maxRadius: 50,
              child: Container()),
          const CustomText(
            text: "R\$ 1.050,00 Reais",
            color: Colors.white,
            size: 16,
          ),
        ],
      ),
    );

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CupertinoListTile(
        // backgroundColor: Colors.blueGrey.shade300,
        leadingSize: 150,
        // onTap: () => onClick(widgetKey),
        leading: mandatoryContainer,
        subtitle: Wrap(
          direction: Axis.vertical,
          alignment: WrapAlignment.center,
          textDirection: TextDirection.rtl,
          runAlignment: WrapAlignment.center,
          runSpacing: 10,
          verticalDirection: VerticalDirection.down,

          children: const [
            Text(
              "Apple Inc. O mais novo produto da Apple com a tencologia mais moderna do mercado",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ],
          //"Animated Apple Product Image $index",
        ),

        trailing: FloatingActionButton.large(
          elevation: 7,
          hoverColor: Colors.green,
          backgroundColor: Colors.white,
          onPressed: () {
            onClick(widgetKey);
          },
          child: CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey.shade300,
            child: Icon(
              Icons.add,
              color: Colors.green,
              size: 60,
            ),
          ),
        ),
        title: const CustomText(
          text: "Apple Macbook Pro 2021",
          size: 24,
          weight: FontWeight.bold,
        ),
      ),
    );
  }
}

class GlassMorphism extends StatelessWidget {
  const GlassMorphism(
      {Key? key,
      required this.child,
      required this.blur,
      this.opacity = 0.5,
      required this.color,
      this.borderRadius,
      this.showGradient = false,
      this.showBoxShadow = false})
      : super(key: key);
  final Widget child;
  final double blur;
  final double opacity;
  final Color color;
  final BorderRadius? borderRadius;
  final bool showGradient;
  final bool showBoxShadow;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              gradient: showGradient
                  ? LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.blueGrey.shade100,
                        Colors.blueGrey.shade200,
                        Colors.blueGrey.shade300,
                        Colors.blueGrey.shade400,
                        Colors.white,
                        Colors.white,
                        Colors.blueGrey.shade200,
                        Colors.blueGrey.shade200,
                        Colors.blueGrey.shade500,
                        Colors.blueGrey.shade600,
                      ],
                    )
                  : null,
              boxShadow: showBoxShadow
                  ? [
                      BoxShadow(
                        color: Colors.white,
                        blurRadius: blur,
                      ),
                      BoxShadow(
                        color: color.withOpacity(opacity),
                        blurRadius: blur,
                      ),
                      BoxShadow(
                        color: Colors.white,
                        blurRadius: blur,
                      ),
                    ]
                  : null,
              color: color.withOpacity(opacity),
              borderRadius: borderRadius),
          child: child,
        ),
      ),
    );
  }
}
