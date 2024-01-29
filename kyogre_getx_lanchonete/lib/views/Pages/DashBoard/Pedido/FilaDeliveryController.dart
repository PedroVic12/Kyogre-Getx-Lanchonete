import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/DashBoardPage.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/Pedido/AlertaPedidoWidget.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/Pedido/PedidoController.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/Pedido/modelsPedido.dart';

class FilaDeliveryController extends GetxController {
  final Rx<Fila> FILA_PEDIDOS = Fila().obs;
  final PedidoController controller = Get.find<PedidoController>();
  final List<dynamic> PEDIDOS_ALERTA_ARRAY = [];

  getFila() => FILA_PEDIDOS;
  getTodosPedidos() => FILA_PEDIDOS.value.todosPedidos();

  void carregarPedidos(List<dynamic> pedidosDoServidor) {
    try {
      print('Número de pedidos no Rayquaza: ${pedidosDoServidor.length}');
      _limparPedidosAntigos();
      _adicionarPedidosNaoExistenteNaFila(pedidosDoServidor);
      _mostrarAlertaSeNecessario();
    } catch (e) {
      print('Erro ao carregar pedidos: $e');
    }
  }


  avancarPedido(){
    //altera status no servidor PUT

    // adicionar +1 na coluna
  }


  resetarPedido(){
    //altera status no servidor PUT

    // adicionar -1 na coluna
  }
  cancelarPedido(){}




  void _limparPedidosAntigos() {
    PEDIDOS_ALERTA_ARRAY.clear();
    print('Tamanho da Fila: ${FILA_PEDIDOS.value.tamanhoFila()}');
  }

  void _adicionarPedidosNaoExistenteNaFila(List<dynamic> pedidosDoServidor) {
    for (var pedidoJson in pedidosDoServidor) {

      print('Número de pedidos para alerta: ${PEDIDOS_ALERTA_ARRAY.length}');
      final pedido = Pedido.fromJson(pedidoJson);


      if (!_pedidoEstaNaFila(pedido)) {
        PEDIDOS_ALERTA_ARRAY.add(pedidoJson);
      }
    }
  }

  bool _pedidoEstaNaFila(Pedido pedido) {
    return FILA_PEDIDOS.value.contemPedidoComId(pedido.id);
  }

  void _mostrarAlertaSeNecessario() {
    if (_haPedidosParaAlerta() && !_alertaEstaAtivo()) {
      _exibirAlertaDePedido(PEDIDOS_ALERTA_ARRAY.removeAt(0));
    }
  }

  bool _haPedidosParaAlerta() {
    return PEDIDOS_ALERTA_ARRAY.isNotEmpty;
  }

  bool _alertaEstaAtivo() {
    return controller.showAlert;
  }

  void _exibirAlertaDePedido(dynamic pedido) {
    try {
      showNovoPedidoAlertDialog(pedido);
    } catch (e) {
      print('Erro ao exibir alerta de pedido: $e');
    }
  }

  void inserirPedido(Pedido pedido) {
    try {
      FILA_PEDIDOS.value.push(pedido);
      FILA_PEDIDOS.refresh();
      print("Pedido inserido. Tamanho da fila agora: ${FILA_PEDIDOS.value.tamanhoFila()}");
    } catch (e) {
      print('Erro ao inserir pedido: $e');
    }
  }

  Pedido? removerPedido() {
    try {
      return FILA_PEDIDOS.value.pop();
    } catch (e) {
      print('Erro ao remover pedido: $e');
      return null;
    }
  }

  Future<void> showNovoPedidoAlertDialog(dynamic pedido) async {
    final pedidoId = pedido['id'];

    if (!_alertaJaFoiMostrado(pedidoId)) {
      _configurarEExibirAlerta(pedido, pedidoId);
    }
  }

  bool _alertaJaFoiMostrado(int pedidoId) {
    return controller.pedidosAlertaMostrado.containsKey(pedidoId);
  }

  Future<void> _configurarEExibirAlerta(dynamic pedido, int pedidoId) async {
    final itensPedido = _obterItensDoPedido(pedido);

    print('Pedido ${pedidoId} não esta na Fila, mostrando o alerta...');
    print('isDashPage: ${_estaNaDashPage()}');
    print('SHOW ALERTA: ${controller.showAlert}');
    print(PEDIDOS_ALERTA_ARRAY);

    if (!_alertaEstaAtivo() && _estaNaDashPage()) {
      await _mostrarAlerta(pedido, itensPedido, pedidoId);
    }
  }

  List<String> _obterItensDoPedido(dynamic pedido) {
    return (pedido['carrinho'] as List<dynamic>)
        .map((item) => item['nome'] as String)
        .toList();
  }

  bool _estaNaDashPage() {
    return Get.currentRoute == '/dash';
  }

  Future<void> _mostrarAlerta(dynamic pedido, List<String> itensPedido, int pedidoId) async {
    controller.showAlert = true;

    await Get.to(() => AlertaPedidoWidget(
      nomeCliente: pedido['nome_cliente'] ?? '',
      enderecoPedido: pedido['endereco'] ?? '',
      itensPedido: itensPedido,
      btnOkOnPress: () {
        _handlePedidoAceito(pedido, pedidoId);
      },
    ));
  }

  void _handlePedidoAceito(dynamic pedido, int pedidoId) {
    _adicionarPedidoNaFila(pedido);
    Get.back();
    _resetarConfiguracoesDeAlerta(pedidoId);
  }

  void _adicionarPedidoNaFila(dynamic pedido) {
    Pedido novoPedido = Pedido.fromJson(pedido);
    inserirPedido(novoPedido);
    print('\n\nPedido Aceito!');
  }


  void _resetarConfiguracoesDeAlerta(int pedidoId) {
    Future.delayed(Duration(milliseconds: 200), () {
      controller.showAlert = false;
      controller.pedidosAlertaMostrado[pedidoId] = true;
      _mostrarAlertaSeNecessario();
    });
  }


}
