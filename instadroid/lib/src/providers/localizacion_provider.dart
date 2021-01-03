

import 'package:geolocator/geolocator.dart';

class LocationProvider {

  Future<Position> getCurrentLocation() async{
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print('Localización: $position');
    return position;
  }
}