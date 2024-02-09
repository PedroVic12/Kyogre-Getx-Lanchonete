import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Monitoramento/maps/services.dart';
import 'package:http/http.dart' as http;

class MapMarker {
  final String id;
  final LatLng position;
  final BitmapDescriptor icon;

  MapMarker({required this.id, required this.position, required this.icon});
}

/*
* 1. Obtenção da Localização do Entregador
No aplicativo do entregador: Use um plugin de localização, como location, para obter a localização em tempo real do entregador e envie esses dados para o seu servidor/backend em intervalos regulares.
No seu servidor/backend: Armazene as atualizações de localização em um banco de dados.

* 2. Monitoramento da Localização do Entregador no App do Cliente
No aplicativo do cliente: Obtenha os dados da localização do entregador do seu servidor em intervalos regulares e atualize a localização no mapa.

*
* 3. Visualizando o Mapa e a Localização do Entregador
No aplicativo do cliente: Use o pacote google_maps_flutter para mostrar o mapa e a rota do entregador até o cliente. Atualize o marcador do entregador conforme a localização do entregador é atualizada.
*
* */



class MapsController extends GetxController {
  final LocationService _locationService = Get.put(LocationService());
  Rx<LatLng> currentPosition = LatLng(0, 0).obs;
  var movingMarkerPosition = LatLng(-22.9510978, -43.1807461).obs;
  final destination = LatLng(-22.907662, -43.5659086);
  RxSet<Marker> markers = <Marker>{}.obs;
  RxList<LatLng> routeCoordinates = <LatLng>[].obs; // Para armazenar a rota

  final apiKey = "AIzaSyBz5PufcmSRVrrmTWPHS2qlzPosL70XrwE";


  @override
  void onInit() {
    super.onInit();
    currentPosition.bindStream(_locationService.currentPosition.stream);
    setupMarkers();
    simulateMovement();
    periodicallyUpdateLocation();
  }

  Future<String> getAddressFromLatLng(LatLng position) async {
    final url = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=AIzaSyBz5PufcmSRVrrmTWPHS2qlzPosL70XrwE';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      if (jsonResponse['results'].length > 0) {
        return jsonResponse['results'][0]['formatted_address'];
      }
    }
    return "Endereço desconhecido";
  }

  void setupMarkers() {
    // Marcadores existentes
    updateMarkers();
  }

  void updateMarkers() {
    markers.clear();
    markers.add(Marker(markerId: MarkerId('source'), position: movingMarkerPosition.value, icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure)));
    markers.add(Marker(markerId: MarkerId('destination'), position: destination, icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose)));
    markers.add(Marker(markerId: MarkerId('current'), position: currentPosition.value, icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen)));
    updateRouteCoordinates(); // Atualiza a rota sempre que os marcadores são atualizados
  }

  void simulateMovement() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (movingMarkerPosition.value != destination) {
        // Lógica simplificada de movimento
        var newLat = movingMarkerPosition.value.latitude + (destination.latitude - movingMarkerPosition.value.latitude) / 100;
        var newLng = movingMarkerPosition.value.longitude + (destination.longitude - movingMarkerPosition.value.longitude) / 100;
        movingMarkerPosition.value = LatLng(newLat, newLng);
        updateMarkers();
      } else {
        timer.cancel();
      }
    });
  }

  void periodicallyUpdateLocation() {
    Timer.periodic(Duration(seconds: 5), (timer) {
      currentPosition.value = _locationService.currentPosition.value; // Atualiza a posição atual a cada 5 segundos
      updateMarkers();
    });
  }

  void updateRouteCoordinates() {
    routeCoordinates.clear();
    routeCoordinates.addAll([movingMarkerPosition.value, destination]); // Simples linha reta para a rota
  }
}
