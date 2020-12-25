import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences{

  //Singleton
  static final UserPreferences _instance = new UserPreferences._internal();

  factory UserPreferences(){
    return _instance;
  }

  UserPreferences._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  get token{
    return _prefs.getString('token') ?? '';
  }

  set token(String token){
    _prefs.setString('token', token);
  }
}