import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kyogre_getx_lanchonete/app/app-web2024/cardapioManager/display_produtos_cadastrados.dart';

import 'package:kyogre_getx_lanchonete/app/widgets/Utils/MenuLateralNavegacao.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Utils/gerador_checklist.dart';

import 'package:kyogre_getx_lanchonete/views/Pages/Caos/tab_page_flip.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Tela%20Cardapio%20Digital/CardapioScreenLayout/TabCardapioAnimated.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Tela%20Cardapio%20Digital/CardapioScreenLayout/animated_cardapio_glass.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/ChatPage/views/ChatPage.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/AuthScreen/tela_auth_jvt.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/TelaDashGestaoPedidos.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Layout/Layout.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Monitoramento/maps/tela_google_maps.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/SplashScreen/splash_screen_page.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Tela%20Cardapio%20Digital/CardapioDigital/CadastroProdutos/cardapio_cadatro_produtos_mongo.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Tela%20Cardapio%20Digital/TelaCardapioDigital.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Tela%20Cardapio%20Digital/cardapio_qrcode.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Tela%20Cardapio%20Digital/controllers/cardapio_controller.dart';

import 'controllers/binding.dart';

//TODO -> Menu controller 1:08

void main() async {
  Gemini.init(apiKey: "AIzaSyBuoUQpUlhv3mAyDipxE519zUwN9B_u1XE");
  print("C3po conectado!");
  Get.put(MenuLateralController());
  Get.put(MenuProdutosController());
  Get.put(CardapioController());
  GlobalBindings().dependencies();
  // WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      //initialRoute: '/splash',

      initialBinding: GlobalBindings(),

      //!  Navegação Padrão Getx do aplicativos de telas. Cada tela = 500 reais!
      getPages: [
        // Telas App (1500 cada)
        GetPage(name: '/', page: () => Layout()),
        GetPage(name: '/splash', page: () => const SplashScreen()),
        GetPage(name: '/dash', page: () => TelaGestaoDePedidosDashBoard()),
        // GetPage(name: '/caosPage', page: () => const NewCardapioDigital2024()),
        //!GetPage(name: "/checklist", page: () => ChecklistPage()),

        // Aministrador Pages
        GetPage(name: '/mapaPedido', page: () => GoogleMapsWidget()),
        GetPage(name: '/login', page: () => const TelaAutenticacaoUsuarios()),
        // GetPage(name: '/atendimento', page: () => const ChatPage()),
        GetPage(name: "/admin", page: () => CardapioManagerPage()),
        GetPage(name: "/api", page: () => DisplayProdutosDatabase()),

        //Pedidos WhatsApp
        GetPage(name: '/cardapio', page: () => const MyCardapioWidget()),
        GetPage(name: "/cardapioDigital", page: () => const TabBarDemo()),
        GetPage(
            name: '/pedido/:id',
            page: () {
              final id = Get.parameters['id']!;

              //id = '1998';
              return TelaCardapioDigital(id: id);
            }),
        GetPage(name: '/cardapioQR', page: () => const CardapioQrCode()),
      ],

      title: 'Ruby IA Delivery APP',
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
