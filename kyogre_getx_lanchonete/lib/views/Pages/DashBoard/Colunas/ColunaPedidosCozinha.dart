
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Custom/CustomText.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/Pedido/AlertaPedidoWidget.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/Pedido/FilaDeliveryController.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/Pedido/PedidoController.dart';

class ColunaPedidosParaAceitar extends StatefulWidget {
  const ColunaPedidosParaAceitar({
    Key? key,
    required this.pedidoController,
  }) : super(key: key);

  final PedidoController pedidoController;

  @override
  _ColunaPedidosParaAceitarState createState() =>
      _ColunaPedidosParaAceitarState();
}

class _ColunaPedidosParaAceitarState extends State<ColunaPedidosParaAceitar> {
  final FilaDeliveryController filaController = Get.put(FilaDeliveryController());

  @override
  void initState() {
    super.initState();
    widget.pedidoController.startFetchingPedidos();
  }

  @override
  Widget build(BuildContext context) {

    final pedidos = widget.pedidoController.pedidosAceitos;

    return Expanded(
      //flex: 1,
      child: Container(
        color: Colors.deepPurple,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Center(
              child: CustomText(text: 'Pedidos Sendo preparados Na Cozinha',weight: FontWeight.bold, size: 20),

            ),

            const SizedBox(height: 10.0),
            Expanded(
              child: Obx(

                    () =>  ListView.builder(
                itemCount: pedidos.length,
                itemBuilder: (context, index) {
                  final pedido = pedidos[index];

                  return Container(
                    color: Colors.white54,
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: Column(
                      children: [
                        CustomText(text: 'Pedido: ${pedido.id}'),


                        CupertinoListTile(
                          title: CustomText(text: 'Pedido ${pedido.id}'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(text: 'Cliente: ${pedido.nome}'),
                              CustomText(text: 'Endereço: ${pedido.endereco}'),
                              CustomText(text: 'Itens do Pedido:'),
                              for (var item in pedido.itensPedido)
                                CustomText(text: '${item['quantidade']}x ${item['nome']} - ${item['preco']}'),
                              CustomText(text: 'Total a Pagar: ${pedido.totalPagar}'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              )
              ),
            ),
          ],
        ),
      ),
    );
  }
}

