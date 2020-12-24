import 'package:flutter/material.dart';
import 'package:instadroid/src/theme/mytheme.dart';

/*Widget para crear los botones de la pantalla de login
y registro, le pasamos el texto que va a tener y una función
que va a ser lo que va a suceder cuanto toquemos el botón*/ 
class LoginRegisterButton extends StatelessWidget {

  final String text;
  final Function onTapEvent;

  const LoginRegisterButton({@required this.text, @required this.onTapEvent});

  @override
  Widget build(BuildContext context) {
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
}