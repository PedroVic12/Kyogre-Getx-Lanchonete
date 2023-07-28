
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kyogre_getx_lanchonete/app/RestAPI/RestAPI.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Design/CartaoGridView.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/CardapioDigital/CardapioDigitalPage.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/DashBoardPage.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Layout/Layout.dart';

import 'views/Pages/DashBoard/Pedido/PedidoController.dart';

//TODO -> Menu controller 1:08

// TODO -> Apresentar pedido na tela quando receber o pedido

void main() {
  Get.put(MenuController());
  Get.put(PedidoController());

  //Get.put(NavigationController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      //initialRoute: authenticationPageRoute,
      //unknownRoute: GetPage(name: '/not-found', page: () => PageNotFound(), transition: Transition.fadeIn),

      // TODO Navegação Padrão
      getPages: [
        GetPage(name: '/', page: () => Layout()),
        GetPage(
            name: '/pedido', page: () => const RestApiPage()), //! Change Here
        GetPage(name: '/dash', page: () => DashboardPage()),
        GetPage(name: '/layoutDesign', page: () => const CartaoGridView()),
        GetPage(name: '/details/:id', page: () {
          final id = Get.parameters['id']!;
          return DetailsPage(id: id);
        }),
      ],

      debugShowCheckedModeBanner: false,
      title: 'Dashboard',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.blueAccent,
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
