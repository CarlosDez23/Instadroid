import 'package:flutter/material.dart';
import 'package:instadroid/src/pages/home_page.dart';
import 'package:instadroid/src/pages/login_page.dart';
import 'package:instadroid/src/pages/publicacion_localizacion_page.dart';
import 'package:instadroid/src/pages/registro_page.dart';
import 'package:instadroid/src/pages/upload_photo_page.dart';
import 'package:instadroid/src/theme/mytheme.dart';
import 'package:instadroid/src/providers/user_preferences.dart';
 
void main() async{
  //Arrancamos las preferencias de usuario para guardar el token
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new UserPreferences();
  await prefs.initPrefs();
  runApp(MyApp());
} 
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Instadroid',
      //Ruta inicial de nuestra aplicación
      initialRoute: 'login',
      /*Pantallas que va a tener la apliación, en flutter se pueden manejar
      como rutas, similar al desarrollo web*/
      routes:{
        'login'        :  (BuildContext context) => LoginPage(),
        'registro'     :  (BuildContext context) => RegistroPage(),
        'home'         :  (BuildContext context) => HomePage(),
        'foto'         :  (BuildContext context) => UploadPhotoPage(),
        'localizacion' :  (BuildContext context) => PhotoLocationPage(),
      },
      //Tema de la aplicación
      theme: myTheme,
      
    );
  }
}