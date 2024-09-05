import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationService extends GetxService {
  final Location _location = Location();
  Rx<LatLng> currentPosition = const LatLng(0, 0).obs;

  Future<LocationService> init() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) return this;
    }

    permissionGranted = await _location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) return this;
    }

    _location.onLocationChanged.listen((LocationData currentLocation) {
      currentPosition.value =
          LatLng(currentLocation.latitude ?? 0, currentLocation.longitude ?? 0);
    });

    return this;
  }
}
