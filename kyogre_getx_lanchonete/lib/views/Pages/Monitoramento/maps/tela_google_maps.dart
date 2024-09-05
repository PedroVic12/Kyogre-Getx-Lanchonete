import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Custom/CustomText.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Design/NightWolfAppBar.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Monitoramento/maps/controllers.dart';

import '../../../../app/widgets/Custom/AssinaturaWidget.dart';

class GoogleMapsWidget extends StatelessWidget {
  final MapsController mapsController = Get.put(MapsController());

  GoogleMapsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              const Text("Pedido = {id}"),
              TextButton(
                onPressed: () {},
                child: const Text('Ajuda'),
              )
            ],
          ),
        ),
        body: ListView(
          scrollDirection: Axis.vertical,
          children: [tempoPrevisaoWidget(), mapaWidget(), statusPedidoUpdate()],
        ));
  }

  Widget tempoPrevisaoWidget() {
    // Este widget pode ser ajustado conforme necessário
    String horarioInicial = "11:40";
    String horarioPrevisto = "12:10";

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.access_time_rounded),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomText(text: "Previsão de entrega"),
              CustomText(text: '$horarioInicial - $horarioPrevisto')
            ],
          )
        ],
      ),
    );
  }

  Widget mapaWidget() {
    return Container(
      padding: const EdgeInsets.all(12),
      height: 300,
      width: 900, // Use a largura total disponível
      child: Obx(() {
        return GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
            target: mapsController.movingMarkerPosition.value,
            zoom: 14,
          ),
          markers: mapsController.markers.toSet(),
          polylines: {
            Polyline(
              polylineId: const PolylineId('route'),
              points: mapsController.routeCoordinates,
              color: Colors.blue,
              width: 5,
            ),
          },
          onMapCreated: (GoogleMapController controller) {},
        );
      }),
    );
  }

  Widget entregadorWidget() {
    return Row(
      children: [
        ElevatedButton(
            style: const ButtonStyle(),
            onPressed: () {},
            child: const Text("Ligar para o estabelicimento"))
      ],
    );
  }

  Widget statusPedidoUpdate() {
    Map<int, String> status = {
      1: "Realizado",
      2: "Aceito",
      3: "Retirado pelo entregador",
      4: "Com sua entrega iniciada",
      5: "Pedido a caminho",
      6: "Finalizado",
    };

    var statusIndex = 1.obs; // Começa com o status 1

    // Incrementa o status até o máximo de 6
    void incrementStatus() {
      if (statusIndex.value < 6) {
        statusIndex.value++;
      }
    }

    return Column(
      children: [
        Obx(() {
          List<Widget> statusWidgets = [];
          for (int i = 1; i <= statusIndex.value; i++) {
            statusWidgets.add(
              Row(
                children: [
                  const Icon(Icons.check_circle, color: Colors.green),
                  const SizedBox(width: 8),
                  CustomText(text: status[i]!),
                ],
              ),
            );
          }
          return Column(children: statusWidgets);
        }),
        ElevatedButton(
          onPressed: incrementStatus,
          child: const Text('Incrementar Status'),
        ),
        AssinaturaWidget()
      ],
    );
  }
}
