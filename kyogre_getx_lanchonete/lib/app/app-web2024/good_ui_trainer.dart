import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Custom/CustomText.dart';

class MyPageView extends StatefulWidget {
  const MyPageView({super.key});

  @override
  _MyPageViewState createState() => _MyPageViewState();
}

class _MyPageViewState extends State<MyPageView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Artistas'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: tabs(), // Adicionei o TabBar aqui
        ),
      ),
      body: ListView(
        children: [
          ArtistaCard(),
          ArtistaCard(),
        ],
      ),
    );
  }

  Widget ArtistaCard() {
    return Container(
      height: 188,
      margin: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: const Center(
        child: Text(
          "Hello",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }

  Widget tabs() {
    return TabBar(
      tabs: const [
        Tab(text: "NEWS"),
        Tab(text: "tab2"),
        Tab(text: "Portfolio"),
      ],
      controller: _tabController,
      isScrollable: true,
      labelColor: context.isDarkMode ? Colors.white : Colors.black,
      indicatorColor: Colors.green,
      padding: const EdgeInsets.all(12),
    );
  }
}

class BasicAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;

  const BasicAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class GoodScreenUI extends StatelessWidget {
  const GoodScreenUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Get.to(MyPageView()); // Navega para MyPageView
          },
          child: const Text('Acessar PageView'),
        ),
      ),
    );
  }
}
