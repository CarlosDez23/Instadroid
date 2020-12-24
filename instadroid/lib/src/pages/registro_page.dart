import 'package:flutter/material.dart';
import 'package:instadroid/src/theme/mytheme.dart';
import 'package:instadroid/src/widgets/background_image.dart';

class RegistroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundImage(),
          SafeArea(
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
                SizedBox(height: 250),
                _doRegisterButton(),
                SizedBox(height: 20),
                _goBackLoginButton(context),
              ],
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
        )
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
        )
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
        )
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
        onPressed: (){},
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
}