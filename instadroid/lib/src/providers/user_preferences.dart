import 'package:shared_preferences/shared_preferences.dart';

/*Clase para las preferencias de usuario, nos servirá para almacenar
en el almacenamiento del dispositivo algunos datos relevantes, en nuestro 
caso el token de auth de firebase y el id que el usuario tiene en la bbdd de
firebase */ 
class UserPreferences{

  //Hacemos un singleton para tener una instancia en toda la aplicación
  static final UserPreferences _instance = new UserPreferences._internal();

  factory UserPreferences(){
    return _instance;
  }

  UserPreferences._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  // Get y sets para los datos a almacenar
  // ?? --> significa que si el elemento es nulo que devuelva en este caso un caracter vacío ''
  get token{
    return _prefs.getString('token') ?? '';
  }

  set token(String token){
    _prefs.setString('token', token);
  }

  get idUsuarioLogueado{
    return _prefs.getString('id') ?? '';
  }

  set idUsuarioLogueado(String id){
    _prefs.setString('id', id);
  }
}