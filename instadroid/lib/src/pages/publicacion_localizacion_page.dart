import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:instadroid/src/models/publicacion_model.dart';



class PhotoLocationPage extends StatefulWidget {
  @override
  _PhotoLocationPageState createState() => _PhotoLocationPageState();
}

class _PhotoLocationPageState extends State<PhotoLocationPage> {

  Completer<GoogleMapController> _controller = Completer();
  MapType mapType = MapType.normal;

  @override
  Widget build(BuildContext context) {

    //Recibimos la publicación de la página anterior
    final Publicacion publicacion = ModalRoute.of(context).settings.arguments;
    //Posición de la cámara
    final CameraPosition posicionInicial = CameraPosition(
      target: LatLng(publicacion.latitud, publicacion.longitud),
      zoom: 17.5,
      tilt: 50,
    );
    //Creación de marcadores
    Set<Marker> markers = new Set<Marker>();
    markers.add(Marker(
      markerId: MarkerId('geo-location'),
      position: LatLng(publicacion.latitud, publicacion.longitud),
      infoWindow: InfoWindow(
        title: publicacion.titulo
      ),
      // icon: BitmapDescriptor.fromAsset('assets/img/bluemarkerjpg.jpg'),
    ));

    return Scaffold(
      body: GoogleMap(
        mapType: mapType,
        markers: markers,
        initialCameraPosition: posicionInicial,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}