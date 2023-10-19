import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Design/NightWolfAppBar.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/Colunas/ColunaInfoPedido.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/Colunas/ColunaPedidosCozinha.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/Colunas/ColunasPedidoProcessados.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/Pedido/FilaDeliveryController.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/Pedido/PedidoController.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/Pedido/PedidosPage.dart';


class DashboardPage extends StatelessWidget {
  final PedidoController pedidoController = Get.find();
  final FilaDeliveryController filaDeliveryController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NightWolfAppBar(),
      body: Column(
        children: [

          //PesquisarDadosWidet(),
          Expanded(child: Row(
            children: [
              //PedidosServer(),
              ColunaPedidosParaAceitar(pedidoController: pedidoController),
              ColunaPedidosProcessados(),
              ColunaInfoPedidos(),
            ],
          ),)
        ],
      )
    );
  }
}
class PesquisarDadosWidet extends StatefulWidget {
  PesquisarDadosWidet({Key? key}) : super(key: key);

  @override
  _PesquisarDadosWidetState createState() => _PesquisarDadosWidetState();
}

class _PesquisarDadosWidetState extends State<PesquisarDadosWidet> {
  var lojas_citta = ['Loja 1', 'Loja 2', 'Loja 3'];
  String? lojaSelecionada;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Row(
        children: [
          Center(
            child: Text('Unidade: ${lojaSelecionada ?? "Selecione uma loja"}'),
          ),
          DropdownButton<String>(
            value: lojaSelecionada,
            hint: Text("Selecione uma loja"),
            items: lojas_citta.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                lojaSelecionada = newValue;
              });
            },
          ),
          SizedBox(width: 8),
          Text('Numero do Pedido'),
          SizedBox(width: 8),
          Text('Buscar pelo Cliente'),
          SizedBox(width: 8),
        ],
      ),
    );
  }
}
