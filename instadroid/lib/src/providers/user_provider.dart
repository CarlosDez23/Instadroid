import 'package:http/http.dart' as http;

import 'dart:convert';
import 'package:instadroid/src/models/usuario_model.dart';
import 'package:instadroid/src/providers/user_preferences.dart';

class UserProvider {

  final String _mainUrl = 'https://instadroid-45787-default-rtdb.europe-west1.firebasedatabase.app';
  final _prefs = UserPreferences();

  //Insertamos los datos del usuario en realtime database de firebase
  Future<bool> agregarUsuario (Usuario usuario) async {
    final url = '$_mainUrl/usuarios.json';
    final resp = await http.post(url, body: usuarioToJson(usuario));
    final Map<String, dynamic> decodedData = json.decode(resp.body);
    //Si lo que nos devuelve contiene name ese es el id que firebase le ha dado 
    if(decodedData.containsKey('name')){
      //Lo almacenamos en las shared prefs
      _prefs.idUsuarioLogueado = decodedData['name'];
    }
    return decodedData.containsKey('name'); 
  }

  //Buscamos un usuario por su id
  Future<Usuario> findUserById(String id) async {
    final url = '$_mainUrl/usuarios/$id.json';
    final resp = await http.get(url);
    return usuarioFromJson(resp.body);
  }
}