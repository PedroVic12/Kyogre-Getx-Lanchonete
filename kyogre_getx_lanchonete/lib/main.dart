import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Design/CartaoGridView.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Utils/MenuLateralNavegacao.dart';
import 'package:kyogre_getx_lanchonete/controllers/DataBaseController/Views/excel_view_database.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/ChatPage/views/ChatPage.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/AuthScreen/tela_auth_jvt.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/DashBoardPage.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Layout/Layout.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Monitoramento/maps/tela_google_maps.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/SplashScreen/splash_screen_page.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Tela%20Cardapio%20Digital/TelaCardapioDigital.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Tela%20Cardapio%20Digital/cardapio_qrcode.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Tela%20Cardapio%20Digital/controllers/cardapio_controller.dart';

import 'controllers/binding.dart';
import 'views/Pages/Caos/caos_page.dart';

//TODO -> Menu controller 1:08

void main() {
  Get.put(MenuLateralController());
  Get.put(MenuProdutosController());
  Get.put(CardapioController());
  GlobalBindings().dependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

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
        GetPage(name: '/cardapioQR', page: () => const CardapioQrCode()),
        GetPage(name: '/mapaPedido', page: () => GoogleMapsWidget()),
        GetPage(name: '/authScreen', page: () => TelaAutenticacaoUsuarios()),
        GetPage(name: '/atendimento', page: () => ChatPage()),
        GetPage(name: '/database', page: () => CardapioSysteam()),
        GetPage(
            name: '/pedido/:id',
            page: () {
              final id = Get.parameters['id']!;

              //id = '1998';
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
