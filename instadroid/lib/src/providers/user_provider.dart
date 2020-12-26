import 'package:http/http.dart' as http;

import 'dart:convert';
import 'package:instadroid/src/models/usuario_model.dart';
import 'package:instadroid/src/providers/user_preferences.dart';

class UserProvider {

  final String _rootElementUrl = 'https://instadroid-45787-default-rtdb.europe-west1.firebasedatabase.app';
  final prefs = UserPreferences();


  Future<bool> agregarUsuario (Usuario usuario) async {
    final url = '$_rootElementUrl/usuarios.json';
    final resp = await http.post(url, body: usuarioToJson(usuario));
    final Map<String, dynamic> decodedData = json.decode(resp.body);
    if(decodedData.containsKey('name')){
      prefs.idUsuarioLogueado = decodedData['name'];
    }
    print('id guardada en prefs: ${prefs.idUsuarioLogueado}');
    return decodedData.containsKey('name'); 
  }



  //Listamos usuarios
  // listUsers() async {
  //   final List<Usuario> usuarios = List();
  //   final url = '$_rootElementUrl/usuarios.json';
  //   final resp = await http.get(url);
  //   final Map<String, dynamic> decodedData = json.decode(resp.body);
  //   decodedData.forEach((id, user) { 
  //     final Usuario usuario = Usuario.fromJson(user);
  //     usuario.idFire = id;
  //     usuarios.add(usuario);
  //   });
  //   print(usuarios[0].idFire);
  // }
}