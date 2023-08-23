import 'package:get/get.dart';

class Pedido {
  dynamic pedido;
  DateTime hora;

  Pedido({required this.pedido, required this.hora});
}



class FilaDeliveryController extends GetxController {
  final _filaPedidos = <Pedido>[].obs;

  List<Pedido> get filaPedidos => _filaPedidos.toList();

  void inserirPedido(Pedido pedido) {
    _filaPedidos.add(pedido);
  }

  Pedido? removerPedido() {
    if (_filaPedidos.isNotEmpty) {
      final pedido = _filaPedidos[0];
      _filaPedidos.removeAt(0);
      return pedido;
    }
    return null;
  }

  bool buscarPedido(Pedido pedido) {
    return _filaPedidos.contains(pedido);
  }
}