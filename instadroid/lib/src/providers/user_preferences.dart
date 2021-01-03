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

  //Lista de publicaciones gustadas
  List<String> _publisMeGusta;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
    this._publisMeGusta = List();
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

  List<String> get publicacionesGustadas => this._publisMeGusta;

  set publicacionesGustadasGuardadas(bool setear){
    if(setear){
      List<String> gustadas = _prefs.getStringList('megustas') ?? List<String>();
      gustadas.addAll(this._publisMeGusta);
      _prefs.setStringList('megustas', gustadas);
    }else{
      //Cambiamos de usuario por lo que borramos sus me gusta de los shared prefs
      _prefs.setStringList('megustas', new List<String>());
    }
  }

  List<String> get publicacionesMeGustaGuardadas => _prefs.getStringList('megustas') ?? List<String>();
}