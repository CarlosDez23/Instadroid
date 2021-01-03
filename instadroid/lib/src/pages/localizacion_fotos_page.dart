import 'package:flutter/material.dart';
import 'package:instadroid/src/models/publicacion_model.dart';
import 'package:instadroid/src/widgets/app_title.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocalizacionFotosPage extends StatelessWidget {

  final Completer<GoogleMapController> _controller = Completer();
  final MapType mapType = MapType.normal;

  
  @override
  Widget build(BuildContext context) {

    final List<Publicacion> listPublicaciones = ModalRoute.of(context).settings.arguments;

    final CameraPosition posicionInicial = CameraPosition(
    target: LatLng(listPublicaciones[0].latitud, listPublicaciones[0].longitud),
    zoom: 17.5,
    tilt: 50,
    );

    //Creación de marcadores
    Set<Marker> markers = new Set<Marker>();

    listPublicaciones.forEach((publicacion) {
      markers.add(Marker(
        markerId: MarkerId('geo-location${publicacion.titulo}'),
        position: LatLng(publicacion.latitud, publicacion.longitud),
        infoWindow: InfoWindow(
          title: publicacion.titulo
        ),
      ));
    });

    return Scaffold(
      appBar: AppBar(
        title: Transform(
          transform:  Matrix4.translationValues(-100.0, 0.0, 0.0),
          child: AppTitle(
            color: Colors.black,
            size: 35.0,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: false,
        leading: IconButton( 
          icon: Icon(Icons.chevron_left, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
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