import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


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


class TrackingPage extends StatefulWidget {
  @override
  _TrackingPageState createState() => _TrackingPageState();
}

class _TrackingPageState extends State<TrackingPage> {
  late GoogleMapController _controller;
  late Marker _delivererMarker;

  // Localização inicial do entregador
  final LatLng _initialPosition = LatLng(-22.9068, -43.1729);

  @override
  void initState() {
    super.initState();
    _delivererMarker = Marker(
      markerId: MarkerId('deliverer'),
      position: _initialPosition,
    );
  }

  void _updateDelivererLocation(LatLng newPosition) {
    setState(() {
      _delivererMarker = Marker(
        markerId: MarkerId('deliverer'),
        position: newPosition,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rastreie sua entrega'),
      ),
      body: GoogleMap(
        onMapCreated: (controller) => _controller = controller,
        markers: {_delivererMarker},
        initialCameraPosition: CameraPosition(
          target: _initialPosition,
          zoom: 14.0,
        ),
      ),
    );
  }
}
