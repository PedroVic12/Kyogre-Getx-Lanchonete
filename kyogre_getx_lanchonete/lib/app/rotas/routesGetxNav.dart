// Classe para armazenar os nomes das rotas
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/app/Teoria%20do%20Caos/CaosPage.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/DashBoardPage.dart';

class Routes {
  static const String HOME = '/';
  static const String LAYOUT_DESIGN = '/layoutDesign';
  static const String DIGITAL_MENU = '/details/:id';
  static const String CAOS_PAGE = '/caosPage';
// TODO: Adicione mais rotas conforme necessário
}

// Classe para configurar os mapeamentos de rotas
class RoutePages {
  static final routes = [
    GetPage(name: Routes.HOME, page: () => DashboardPage()),
    GetPage(
        name: Routes.CAOS_PAGE,
        page: () => const CaosPage()), // Rota '/caosPage'
    // TODO: Adicione mais mapeamentos de rotas conforme necessário
  ];
}
