import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:instadroid/src/models/publicacion_model.dart';

class PublicacionesProvider{

  final String _baseUrl = 'https://instadroid-45787-default-rtdb.europe-west1.firebasedatabase.app';

  //Listamos las publicaciones que tenemos en Firebase
  Future<List<Publicacion>> listarPublicaciones() async {
    
    final url = '$_baseUrl/publicaciones.json';
    final List<Publicacion> list = List<Publicacion>();
    final resp = await http.get(url);
    final Map <String, dynamic> decodedResp = json.decode(resp.body);
    
    if(decodedResp == null){
      return [];
    }
    decodedResp.forEach((id, publicacion){
      final Publicacion publi = Publicacion.fromJson(publicacion);
      publi.idPublicacion = id;
      list.add(publi);
    });
    return list;
  }

  //Borramos una publicación de Firebase

  Future<bool> borrarPublicacion (String idPublicacion) async {
    final url = '$_baseUrl/publicaciones/$idPublicacion.json';
    await http.delete(url);
    return true;
  }

}