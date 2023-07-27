import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Custom/CustomText.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Design/NightWolfAppBar.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/InfoCards/InfoCard.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Pedido/AlertaPedidoWidget.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/Pedido/CardPedido.dart';
import 'dart:async';
import 'dart:io';

import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/Pedido/PedidoController.dart';


class Dashboard extends StatelessWidget {
  final PedidoController pedidoController = Get.put(PedidoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NightWolfAppBar(),
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AlertaPedidoChegando(),

                  CustomText(text: 'Pedidos para serem Aceitos'),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    onPressed: () {
                      pedidoController.fetchPedidos();
                    },
                    child: Text('Atualizar Pedidos'),
                  ),
                  SizedBox(height: 8.0),
                  Expanded(
                    child: Obx(
                          () => ListView.builder(
                        itemCount: pedidoController.pedidos.length,
                        itemBuilder: (context, index) {
                          final pedido = pedidoController.pedidos[index];

                          return Dismissible(
                            key: UniqueKey(),
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
                              pedidoController.removePedido(pedido);
                            },
                            child: GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text('Detalhes do Pedido'),
                                    content: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Itens do Pedido:'),
                                        ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: pedido['itensPedido'].length,
                                          itemBuilder: (context, index) {
                                            final item = pedido['itensPedido'][index];
                                            return ListTile(
                                              title: Text(item['nome']),
                                              subtitle: Text(item['descricao']),
                                              trailing: Text('R\$ ${item['preco']}'),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: () {
                                          pedidoController.aceitarPedido(pedido);
                                          Navigator.pop(context);
                                        },
                                        child: Text('Aceitar Pedido'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('Fechar'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              child: CardPedido(

                                nome: pedido['nome'],
                                telefone: pedido['telefone'],
                                itensPedido: (pedido['carrinho']['itensPedido'] as List<dynamic>)
                                    .map((item) => item as Map<String, dynamic>)
                                    .toList(),
                                totalPrecoPedido: pedido['carrinho']['totalPrecoPedido'].toDouble(),
                                formaPagamento: pedido['forma_pagamento'],
                                enderecoEntrega: pedido['endereco_cliente'],
                                onTap: () {  },
                                onEnviarEntrega: () {  },
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Column(
            children:  [
              CustomText(text: 'Pedidos sendo processados'),

            ],
          ),


          Expanded(
            flex: 1,
            child: Container(
              width: 200.0,
              padding: EdgeInsets.all(8.0),
              child: Obx(
                    () => InfoCard(
                  title: "Pedidos Recebidos",
                  value: pedidoController.pedidos.length.toString(),
                  onTap: () {
                    pedidoController.fetchPedidos();
                  },
                  isActive: true,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
