import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:instadroid/src/models/usuario_model.dart';

class LoginAuthProvider {

  final String _apiKey                = 'AIzaSyA6R47Ui5Wep9u44y4BKc3cYk3ZX69J6LY';
  final String _baseUrl               = 'https://identitytoolkit.googleapis.com/v1/accounts:';
  final String _registerServiceToken  = 'signUp?key=';
  final String _loginServiceToken     = 'signInWithPassword?key=';


  //Damos de alta un usuario en Firebase
  Future<bool> createUserFirebase(Usuario usuario) async {
    final url = '$_baseUrl$_registerServiceToken$_apiKey';
    print(url);
    final userData = {
      'email'             : usuario.email,
      'password'          : usuario.password,
      'returnSecureToken' : true
    };
    return await _handleResponse(url, json.encode(userData));
  }

  //Login contrqa firebase
  Future<bool> loginFirebase(Usuario usuario) async {
    final url = '$_baseUrl$_loginServiceToken$_apiKey';
    print(url);
    final userData = {
      'email'             : usuario.email,
      'password'          : usuario.password,
      'returnSecureToken' : true
    };
    return await _handleResponse(url, json.encode(userData));
  }

  Future<bool> _handleResponse(String url, String requestBody) async{
    final resp = await http.post(url, body: requestBody);
    Map<String, dynamic> decodedResponse = json.decode(resp.body);
    return decodedResponse.containsKey('idToken');
  }
}