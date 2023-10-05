import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kyogre_getx_lanchonete/api/Raichu.dart';
import 'package:location/location.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final RaichuApi _api = RaichuApi();  // Instancie a API
  final Location _location = Location();
  late GoogleMapController _mapController;
  late LatLng _currentLocation;

  @override
  void initState() {
    super.initState();
    _getLocationUpdates();
  }

  void _getLocationUpdates() async {
    await _location.requestPermission();
    _location.onLocationChanged.listen((LocationData currentLocation) {
      setState(() {
        _currentLocation = LatLng(currentLocation.latitude!, currentLocation.longitude!);
      });
      _updateLocationToServer();
    });
  }

  void _updateLocationToServer() async {
    // Atualize a localização para o servidor

  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: (controller) => _mapController = controller,
      initialCameraPosition: CameraPosition(
        target: _currentLocation,
        zoom: 15,
      ),
    );
  }
}
