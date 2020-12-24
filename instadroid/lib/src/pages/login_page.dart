import 'package:flutter/material.dart';
import 'package:instadroid/src/theme/mytheme.dart';
import 'package:instadroid/src/widgets/app_title.dart';
import 'package:instadroid/src/widgets/background_image.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Stack(
        children: <Widget> [
          BackgroundImage(),
          SafeArea(
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
                SizedBox(height: 250),
                _loginButton(),
                SizedBox(height: 20),
                _registerButton(context),    
              ],
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
        onPressed: (){},
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
        onPressed: () => Navigator.pushNamed(context, 'registro'),
      ),
    );
  }
}