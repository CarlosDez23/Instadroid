import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:instadroid/src/models/publicacion_model.dart';
import 'package:instadroid/src/providers/user_preferences.dart';

class PublicacionesProvider{

  final String _baseUrl = 'https://instadroid-45787-default-rtdb.europe-west1.firebasedatabase.app';
  final _prefs = UserPreferences();

  //Listamos las publicaciones que tenemos en Firebase
  Future<List<Publicacion>> listarPublicaciones() async {
    //auth es el método de autenticación de firebase, por lo que mandamos el token que firebase
    //nos manda cuando el usuario se loguea
    final url = '$_baseUrl/publicaciones.json?auth=${_prefs.token}';
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

  //Insertamos publicación
  Future<bool> insertarPublicacion(Publicacion publicacion) async {

    final url = '$_baseUrl/publicaciones.json?auth=${_prefs.token}'; 
    final resp = await http.post(url, body: publicacionToJson(publicacion));
    final decodedResp = json.decode(resp.body);
    print(decodedResp);
    return true;
  }

  //Editamos publicación
  Future<bool> editarPublicacion(Publicacion publicacion) async {

    final url = '$_baseUrl/publicaciones/${publicacion.idPublicacion}.json?auth=${_prefs.token}';
    final resp = await http.put(url, body: publicacionToJson(publicacion));
    final decodedResp = json.decode(resp.body);
    return true;
  }

  //Borramos una publicación de Firebase
  Future<bool> borrarPublicacion (String idPublicacion) async {
    final url = '$_baseUrl/publicaciones/$idPublicacion.json?auth=${_prefs.token}';
    await http.delete(url);
    return true;
  }

}