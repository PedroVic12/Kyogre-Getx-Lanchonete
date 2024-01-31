import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Custom/CustomText.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/Pedido/CardPedido.dart';

import '../../../app/widgets/Design/NightWolfAppBar.dart';
import '../Tela Cardapio Digital/controllers/pikachu_controller.dart';
import 'Pedido/FilaDeliveryController.dart';
import 'Pedido/PedidoController.dart';
import 'Pedido/PedidosPage.dart';
import 'Pedido/modelsPedido.dart';

class TelaGestaoDePedidosDashBoard extends StatelessWidget {
  TelaGestaoDePedidosDashBoard({Key? key}) : super(key: key);

  final FilaDeliveryController filaDeliveryController = Get.put(FilaDeliveryController());
  final PedidoController pedidoController =   Get.put(PedidoController(Get.find<FilaDeliveryController>()));
  final pikachu = PikachuController();




  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: NightWolfAppBar(),
      body: Row(
        children: [
          _buildColunaPedidos(1, 'Pedidos em Produção', Colors.red),
          _buildColunaPedidos(2, 'Pedidos para Entrega', Colors.orange),
          _buildColunaPedidos(3, 'Pedidos Finalizados', Colors.green),
        ],
      ),
    );
  }

  Widget _buildColunaPedidos(int index, String titulo, Color color) {

    var pedidoSetState = pedidoController.getIndexStatus(index);
    pikachu.cout("Estagio Pedido = $pedidoSetState");


    return Expanded(
      child: Container(
        color: color,
        child: Column(
          children: [
            Text("$titulo -> ($index)", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Divider(
              color: Colors.black,
            ),
            const SizedBox(height: 10.0),


          Expanded(child: simpleCard(pedidoSetState),)

          ],
        ),
      ),
    );
  }

  Widget simpleCard(String state) {
    final tamanhoFila = filaDeliveryController.FILA_PEDIDOS.value.tamanhoFila();
    print("Itens na fila: $tamanhoFila");
    List<Pedido> pedidosFiltrados = filaDeliveryController.getTodosPedidos().where((pedido) => pedido.status == state).toList();


    return ListView.builder(
      itemCount: pedidosFiltrados.length,
      itemBuilder: (context, index) {
        final pedido = pedidosFiltrados[index];
        pikachu.cout("${pedido.nome_cliente} - ${pedido.status} - ${state}");

        if(pedido.status == state)
          return Card(child: ListTile(
            title: Text("Pedido: ${pedido.id}"),
            subtitle: Column(children: [
              Text("Status: ${pedido.status}"),
              CustomText(text: pedido.nome_cliente)
            ]),

            trailing: Wrap(
              spacing: 12, // Espaçamento entre os botões
              children: <Widget>[

                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    pedidoController.retrocederPedido(pedido.id);
                    //pedidoController.atualizarStatusPedidoServer(pedido.id,"push");
                  },
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward),
                  onPressed: () {
                    pedidoController.avancarPedido(pedido.id);
                  }

                ),
              ],
            ),

            // Adicione aqui mais informações do pedido conforme necessário
          ),);

        }


    );
  }



}

