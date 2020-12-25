import 'package:flutter/material.dart';
import 'package:instadroid/src/models/usuario_model.dart';
import 'package:instadroid/src/providers/loginauth_provider.dart';
import 'package:instadroid/src/theme/mytheme.dart';
import 'package:instadroid/src/widgets/background_image.dart';
import 'package:instadroid/utils/utils.dart' as utils;

class RegistroPage extends StatefulWidget {
  @override
  _RegistroPageState createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {

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
        children: [
          BackgroundImage(),
          SafeArea(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: _emailInput(),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: _passwordInput(),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: _usernameInput(),
                  ),
                  SizedBox(height: 100),
                  (_cargando)
                  ? CircularProgressIndicator(backgroundColor: myTheme.primaryColor)
                  : Container(),
                  SizedBox(height: 150),
                  _doRegisterButton(),
                  SizedBox(height: 20),
                  _goBackLoginButton(context),
                ],
              ),
            )
          )
        ],
      )
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

  Widget _usernameInput(){
    return Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(255,255,255, 0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 6),
      child: TextFormField(
        decoration: InputDecoration(
          icon: Icon(Icons.person, color: myTheme.primaryColor),
          labelText: 'nombre de usuario',
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
        onSaved: (value) => user.nombreUsuario = value,
        validator: (value){
          if(value.length >= 6){
            return null;
          }else{
            return 'El nombre de usuario debe tener 6 o más caracteres';
          }
        }
      ),
    );
  }

  Widget _doRegisterButton(){
    return Container(
      width: 300,
      child: RaisedButton(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal:80.0, vertical: 15.0),
          child: Text('Registrarme'),
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

  Widget _goBackLoginButton(BuildContext context){
    return Container(
      width: 300,
      child: RaisedButton(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal:80.0, vertical: 15.0),
          child: Text('Volver'),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 0.0, 
        color: myTheme.buttonColor,
        textColor: Colors.white,
        onPressed: () => Navigator.pushReplacementNamed(context, 'login'),
      ),
    );
  }

  void _submit() async {
    final registerProvider = LoginAuthProvider();
    if(!formKey.currentState.validate()){
      return;
    }
    formKey.currentState.save();
    setState(() {
      _cargando = !_cargando;
    });
    bool registrado = await registerProvider.createUserFirebase(user);
    setState(() {
      _cargando = !_cargando;
    });
    if(registrado){
      print('Correctamente registrado');
    }else{
      print('Ocurrió un problema con el registro');
    }
  }
}