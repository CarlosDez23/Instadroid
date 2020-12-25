import 'package:flutter/material.dart';
import 'package:instadroid/src/models/usuario_model.dart';
import 'package:instadroid/src/providers/loginauth_provider.dart';
import 'package:instadroid/src/theme/mytheme.dart';
import 'package:instadroid/src/widgets/app_title.dart';
import 'package:instadroid/src/widgets/background_image.dart';
import 'package:instadroid/src/utils/utils.dart' as utils;

class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final formKey = GlobalKey<FormState>();
  final user = Usuario();

  bool _cargando;

  @override
  void initState() { 
    super.initState();
    _cargando = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Stack(
        children: <Widget> [
          BackgroundImage(),
          SafeArea(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget> [
                  AppTitle(
                    color: Colors.white,
                    size: 50.0,
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: _emailInput(),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: _passwordInput(),
                  ),
                  SizedBox(height: 100),
                  (_cargando)
                  ? CircularProgressIndicator(backgroundColor: myTheme.primaryColor)
                  : Container(),
                  SizedBox(height: 150),
                  _loginButton(),
                  SizedBox(height: 20),
                  _registerButton(context),    
                ],
              ),
            ),
          ),
        ]
      ),
    );
  }

  Widget _emailInput(){
    return Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(255,255,255, 0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 6),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          icon: Icon(Icons.mail_outline, color: myTheme.primaryColor),
          labelText: 'email',
          labelStyle: TextStyle(
            color: myTheme.primaryColor,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0)
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(
              color: myTheme.primaryColor,
              width: 2.0,
            ),
          ),  
        ),
        onSaved: (value) => user.email = value,
        validator: (value){
          if(utils.isAEmail(value)){
            return null;
          }else{
            return 'Introduce un email válido';
          }
        }
      ),
    );
  }

  Widget _passwordInput(){
    return Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(255,255,255, 0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 6),
      child: TextFormField(
        obscureText: true,
        decoration: InputDecoration(
          icon: Icon(Icons.lock_outline, color: myTheme.primaryColor),
          labelText: 'password',
          labelStyle: TextStyle(
            color: myTheme.primaryColor,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0)
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(
              color: myTheme.primaryColor,
              width: 2.0,
            ),
          ),  
        ),
        onSaved: (value) => user.password = value,
        validator: (value){
          if(value.length >= 8){
            return null;
          }else{
            return 'La contraseña debe tener 8 o más caracteres';
          }
        }
      ),
    );
  }

  Widget _loginButton(){
    return Container(
      width: 300,
      child: RaisedButton(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal:80.0, vertical: 15.0),
          child: Text('Login'),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 0.0, 
        color: myTheme.buttonColor,
        textColor: Colors.white,
        onPressed: () => _submit(),
      ),
    );
  }

  Widget _registerButton(BuildContext context){
    return Container(
      width: 300,
      child: RaisedButton(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal:80.0, vertical: 15.0),
          child: Text('Registro'),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 0.0, 
        color: myTheme.buttonColor,
        textColor: Colors.white,
        onPressed: () => Navigator.pushReplacementNamed(context, 'registro'),
      ),
    );
  }

  void _submit() async {
    final loginProvider = LoginAuthProvider();
    if(!formKey.currentState.validate()){
      return;
    }
    formKey.currentState.save();
    setState(() {
      _cargando = !_cargando;
    });
    bool isLogged = await loginProvider.loginFirebase(user);
    setState(() {
      _cargando = !_cargando;
    });
    if(isLogged){
      print('Usuario logueado');
    }else{
      print('Usuario no logueado');
    }    //Realizar login en firebase
  }
}