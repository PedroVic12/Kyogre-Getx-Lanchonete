import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  GlobalKey<CartIconKey> cartKey = GlobalKey<CartIconKey>();
  late Function(GlobalKey) runAddToCartAnimation;
  var _cartQuantityItems = 0;
  double _appBarHeight = 160.0; // Initial app bar height

  @override
  Widget build(BuildContext context) {
    return AddToCartAnimation(
      cartKey: cartKey,
      height: 120,
      width: 120,
      opacity: 0.85,
      dragAnimation: const DragToCartAnimationOptions(
        rotation: true,
      ),
      jumpAnimation: const JumpAnimationOptions(),
      createAddToCartAnimation: (runAddToCartAnimation) {
        this.runAddToCartAnimation = runAddToCartAnimation;
      },
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: _appBarHeight,
                pinned: true, // Keep the app bar pinned
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(widget.title),
                  centerTitle: false,
                  background: Container(
                    color: Colors.black.withOpacity(0.4),
                  ),
                ),
                centerTitle: true,
                actions: [
                  IconButton(
                    icon: const Icon(
                      Icons.clear,
                      size: 50, // Reduced icon size
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
            children: List.generate(
              15,
              (index) => AppListItem(
                onClick: listClick,
                index: index,
              ),
            ),
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
      _appBarHeight = 130.0; // Reduced height when scrolled
    });
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
          border: Border.all(color: Colors.blueGrey, width: 0.5),
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.blue,
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              blurRadius: 5.0,
            ),
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart,
            color: Colors.white,
            size: 64,
          ),
          Text(
            "R\$ 1.000,00",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );

    return Card(
      color: Colors.blueGrey.shade300,
      child: CupertinoListTile(
        leadingSize: 150,
        onTap: () => onClick(widgetKey),
        //subtitle: mandatoryContainer,
        leading: mandatoryContainer,
        title: Text(
          "Animated Apple Product Image $index",
        ),
      ),
    );
  }
}
