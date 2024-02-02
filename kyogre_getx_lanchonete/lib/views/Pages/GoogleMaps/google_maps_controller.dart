

// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:location/location.dart';

class GoogleMapsController extends GetxController {
  final google_api_key = "AIzaSyBz5PufcmSRVrrmTWPHS2qlzPosL70XrwE";
  final trackingController = Get.put(TrackingController());
  // Dados
  static const LatLng sourceLocation = LatLng(-22.9510978, -43.1807461);
  static const LatLng destination = LatLng(-22.907662, -43.5659086);
  var endereco_1 = PointLatLng(sourceLocation.latitude,sourceLocation.longitude);
  var endereco_2 = PointLatLng(destination.latitude,destination.longitude);
  LocationData? localizacaoAtual;
  List<LatLng> coordenadas = [];

   final Completer<GoogleMapController> googleMapController = Completer();

  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;

  @override
  void onReady() {
    setInitialLocation("Campo Grande RJ");
    setDestinationLocation("Botafogo RJ");
    print("Debug = $localizacaoAtual");
  }

  void getPolyPoints() async {
    PolylinePoints linhasRotas = PolylinePoints();
    PolylineResult result = await linhasRotas.getRouteBetweenCoordinates(google_api_key, endereco_1, endereco_2);


    if (result.points.isNotEmpty) {
      result.points.forEach((element) {
        coordenadas.add(LatLng(element.latitude, element.longitude));
      });
    }



  }

  void setInitialLocation(String adress) async {
    final sourceLatLng =
    await getLatLngFromAddress(adress, google_api_key);
    print("$adress = $sourceLatLng");
    // Use sourceLatLng para adicionar um marcador ao mapa
  }

  void setDestinationLocation(String adress) async {
    final destinationLatLng =
    await getLatLngFromAddress(adress, google_api_key);
    print("$adress = $destinationLatLng");
  }

  Future<LatLng?> getLatLngFromAddress(String address, String apiKey) async {
    try{
      final url =
          'https://maps.googleapis.com/maps/api/geocode/json?address=$address&key=$apiKey';
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final location = jsonResponse['results'][0]['geometry']['location'];
        return LatLng(location['lat'], location['lng']);
      }
    } catch (e){
      print('Error ao buscar a localizacao: $e');
    }

  }



  void getLocalizacaoAtual() async {
    Location location = Location();
    try {
      LocationData? locData = await location.getLocation();
      if (locData != null) {
        localizacaoAtual = locData;
        update(); // Notifica a UI
      }
    } catch (e) {
      print("Erro ao obter localização: $e");
    }

    location.onLocationChanged.listen((LocationData currentLocation) {
      localizacaoAtual = currentLocation;
      update(); // Notifica a UI
    });
  }


  void setCustomMarkerIcon(){
    BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, "").then((value) => sourceIcon = value);

    BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, "").then((value) => destinationIcon = value);

    BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, "").then((value) => currentLocationIcon = value);

  }



}


class TrackingController extends GetxController {
  var currentMarkerPosition = LatLng(-22.9510978, -43.1807461).obs;
  final LatLng destination = LatLng(-22.907662, -43.5659086);

  @override
  void onInit() {
    super.onInit();
    simulateMovement();
  }

  void simulateMovement() {
    const step = 0.0001;
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (currentMarkerPosition.value.latitude < destination.latitude && currentMarkerPosition.value.longitude < destination.longitude) {
        var newLat = currentMarkerPosition.value.latitude + step;
        var newLng = currentMarkerPosition.value.longitude + step;
        currentMarkerPosition.value = LatLng(newLat, newLng);
      } else {
        timer.cancel();
      }
    });
  }
}