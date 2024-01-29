import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter_web/google_maps_flutter_web.dart'
as googleMaps;
import 'package:kyogre_getx_lanchonete/app/Teoria%20do%20Caos/CaosPage.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/GoogleMaps/google_maps_controller.dart';

class PedidoTrackingMapsScreen extends StatefulWidget {
  const PedidoTrackingMapsScreen({super.key});

  @override
  State<PedidoTrackingMapsScreen> createState() =>
      _PedidoTrackingMapsScreenState();
}

class _PedidoTrackingMapsScreenState extends State<PedidoTrackingMapsScreen> {
  final google_api_key = "AIzaSyBz5PufcmSRVrrmTWPHS2qlzPosL70XrwE";
  final controller = Get.put(GoogleMapsController());


// Dados
  static const LatLng sourceLocation = LatLng(-22.9510978, -43.1807461);
  static const LatLng destination = LatLng(-22.907662, -43.5659086);



//variaveis
  bool showMaps = true;
  List<Marker> marker_array = [];

  @override
  void initState() {
    super.initState();
    marker_array.add(
      const Marker(
        markerId: MarkerId('source'),
        position: sourceLocation,
        icon: BitmapDescriptor.defaultMarker,
      ),
    );
    setState(() {
      controller.getPolyPoints();
      controller.getLocalizacaoAtual();
      //controller.setCustomMarkerIcon();
    });

    if (marker_array.isNotEmpty) {
      setState(() {
        showMaps = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    if (kIsWeb) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Google Maps Web'),
        ),
        body: ListView(children: [

          Mapa(),
          localAtualizadoDispositivo(),
        ],)
      );
    } else {
      return const Center(
        child: Text('Executando em um dispositivo móvel'),
      );
    }
  }

  Widget localAtualizadoDispositivo(){
    var currentLocation = controller.localizacaoAtual != null
        ? LatLng(controller.localizacaoAtual!.latitude!, controller.localizacaoAtual!.longitude!)
        : sourceLocation; // Fallback para uma localização padrão

    controller.getPolyPoints(); // Chama para obter os pontos da rota

    if (controller.localizacaoAtual == null ){
      return Center(child: LoadingWidget());
    } else {
      return Container(
        padding: EdgeInsets.all(12),
        height: 300,
        width: 600,
        child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(target: currentLocation, zoom: 13.5),
          polylines: {
            Polyline(polylineId: PolylineId('route'),
                points: controller.coordenadas,
                color: Colors.red,
                width: 5
            )
          },
          markers: {
            Marker(
              markerId: MarkerId('currentLocation'),
              position: currentLocation, // Usa a localização atual
              icon: controller.currentLocationIcon,
            ),
            Marker(
              markerId: MarkerId('source'),
              position: sourceLocation,
              icon: controller.sourceIcon,
            ),
            Marker(
              markerId: MarkerId('destination'),
              position: destination,
              icon: controller.destinationIcon,
            ),
          },
          onMapCreated: (mapController){
            controller.googleMapController.complete(mapController);
          },
        ),
      );
    }
  }

  Widget Mapa(){
    return   Container(
      padding: EdgeInsets.all(12),
      height: 300,
      width: 600,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition:
        const CameraPosition(target: sourceLocation, zoom: 13.5),
        polylines: {
          Polyline(polylineId: PolylineId('route'),
              points: controller.coordenadas,
              color: Colors.blue,
              width: 6
          )
        },

        markers: {
          const Marker(
            markerId: MarkerId('source'),
            position: sourceLocation,
            icon: BitmapDescriptor.defaultMarker,
          ),
          const Marker(
            markerId: MarkerId('destination'),
            position: destination,
            icon: BitmapDescriptor.defaultMarker,
          ),
        },
      ),
    );
  }

}
