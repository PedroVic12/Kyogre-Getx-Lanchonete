import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kyogre_getx_lanchonete/app/Teoria%20do%20Caos/CaosPage.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Design/CartaoGridView.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Utils/MenuLateral.dart';
import 'package:kyogre_getx_lanchonete/models/DataBaseController/DataBaseController.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/CardapioDigitalPage.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/CatalogoProdutos/CatalogoProdutosController.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/DashBoardPage.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/Pedido/FilaDeliveryController.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Layout/Layout.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/SplashScreen/splash_screen_page.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Tela%20Cardapio%20Digital/TelaCardapioDigital.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Tela%20Cardapio%20Digital/views/menu_tab_bar_widget.dart';

import 'controllers/binding.dart';
import 'views/Pages/Caos/caos_page.dart';
import 'views/Pages/DashBoard/Pedido/PedidoController.dart';

//TODO -> Menu controller 1:08

void main() {
  Get.put(MenuLateralController());

  Get.put(PedidoController());
  Get.put(FilaDeliveryController());

  //Get.put(DataBaseController());
  //Get.put(CatalogoProdutosController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      //initialRoute: '/splash',

      initialBinding: GlobalBindings(),

      // TODO Navegação Padrão
      getPages: [
        GetPage(name: '/', page: () => Layout()),
        GetPage(name: '/splash', page: () => const SplashScreen()),
        GetPage(name: '/dash', page: () => DashboardPage()),
        GetPage(name: '/layoutDesign', page: () => const CartaoGridView()),
        GetPage(name: '/caosPage', page: () => const CaosPageWidget()),
        GetPage(
            name: '/pedido/:id',
            page: () => const TelaCardapioDigital(
                  id: '1998',
                )),
        GetPage(
            name: '/details/:id',
            page: () {
              final id = Get.parameters['id']!;
              return DetailsPage(id: id);
            }),



        GetPage(
            name: '/pedido/:id',
            page: () {
              final id = Get.parameters['id']!;
              return TelaCardapioDigital(id: id);
            }),
      ],


      title: 'Dashboard',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.indigo.shade700,
        useMaterial3: true,
        textTheme: GoogleFonts.mulishTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.black),
        pageTransitionsTheme: const PageTransitionsTheme(builders: {
          TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
        }),
        primarySwatch: Colors.blueGrey,
      ),
      home: Layout(),
    );
  }
}
