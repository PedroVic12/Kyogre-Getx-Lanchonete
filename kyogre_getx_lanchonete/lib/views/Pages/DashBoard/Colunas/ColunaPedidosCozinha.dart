
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Custom/CustomText.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/Pedido/AlertaPedidoWidget.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/Pedido/CardPedido.dart';
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
    return Expanded(
      flex: 1,
      child: Container(
        color: Colors.deepPurple,
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Center(
              child: CustomText(text: 'Pedidos Sendo preparados Na Cozinha',weight: FontWeight.bold, size: 20),

            ),

            SizedBox(height: 10.0),
            Expanded(
              child: Obx(
                    () => ListView.builder(
                  itemCount: widget.pedidoController.pedidos.length,
                  itemBuilder: (context, index) {
                    final pedido = widget.pedidoController.pedidos[index];
                    return Dismissible(
                        key: Key(pedido['id'].toString()),
                        background: Container(
                          color: Colors.red,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: EdgeInsets.only(right: 16.0),
                              child: Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) {
                          setState(() {
                            widget.pedidoController.removePedido(pedido);
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.all(12),
                          child: GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertaPedidoWidget(
                                  nomeCliente: pedido['nome'],
                                  enderecoPedido: pedido['endereco_cliente'],
                                  itensPedido: pedido['itensPedido'],
                                ),
                              );
                            },
                            child: CardPedido(
                              nome: pedido['nome'],
                              telefone: pedido['telefone'],
                              itensPedido: (pedido['carrinho']['itensPedido']
                              as List<dynamic>)
                                  .map((item) => item as Map<String, dynamic>)
                                  .toList(),
                              totalPrecoPedido:
                              pedido['carrinho']['totalPrecoPedido']
                                  .toDouble(),
                              formaPagamento: pedido['forma_pagamento'],
                              enderecoEntrega: pedido['endereco_cliente'],
                              onTap: (){},
                              onEnviarEntrega: (){},

                            ),
                          ),
                        )
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

