import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:kyogre_getx_lanchonete/views/Pages/GoogleMaps/google_maps_controller.dart';

import 'package:location/location.dart';

import '../Monitoramento/maps/tela_google_maps.dart';

class PedidoTrackingMapsScreen extends StatefulWidget {
  const PedidoTrackingMapsScreen({super.key});

  @override
  State<PedidoTrackingMapsScreen> createState() =>
      _PedidoTrackingMapsScreenState();
}

class _PedidoTrackingMapsScreenState extends State<PedidoTrackingMapsScreen> {
  final google_api_key = "AIzaSyBz5PufcmSRVrrmTWPHS2qlzPosL70XrwE";
  final controller = Get.put(GoogleMapsController());
  final Location _locationController = Location();
  LatLng? _currentPosition;

// Dados
  static const LatLng sourceLocation = LatLng(-22.9510978, -43.1807461);
  static const LatLng destination = LatLng(-22.907662, -43.5659086);

  Future<void> _getLocationUpdates() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await _locationController.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _locationController.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await _locationController.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _locationController.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationController.onLocationChanged
        .listen((LocationData currentLocation) {
      setState(() {
        _currentPosition =
            LatLng(currentLocation.latitude!, currentLocation.longitude!);
      });
    });
  }

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
    Set<Marker> markers = {
      const Marker(
        markerId: MarkerId('source'),
        position: GoogleMapsController.sourceLocation,
        icon: BitmapDescriptor.defaultMarker,
      ),
      const Marker(
        markerId: MarkerId('destination'),
        position: GoogleMapsController.destination,
        icon: BitmapDescriptor.defaultMarker,
      ),
      Marker(
        markerId: const MarkerId('moving'),
        position: controller.trackingController.currentMarkerPosition.value,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
      ),
    };

    if (_currentPosition != null) {
      markers.add(
        Marker(
          markerId: const MarkerId('currentPosition'),
          position: _currentPosition!,
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        ),
      );
    }
    if (kIsWeb) {
      return Scaffold(
          appBar: AppBar(
            title: const Text('Google Maps Web'),
          ),
          body: ListView(
            children: [
              ElevatedButton(
                  onPressed: () => Get.to(GoogleMapsWidget()),
                  child: const Text("Track page")),
              MapaWidget(),
            ],
          ));
    } else {
      return const Center(
        child: Text('Executando em um dispositivo móvel'),
      );
    }
  }

  Widget MapaWidget() {
    return Container(
      padding: const EdgeInsets.all(12),
      height: 300,
      width: 600,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition:
            const CameraPosition(target: sourceLocation, zoom: 13.5),
        polylines: {
          Polyline(
              polylineId: const PolylineId('route'),
              points: controller.coordenadas,
              color: Colors.blue,
              width: 6)
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
