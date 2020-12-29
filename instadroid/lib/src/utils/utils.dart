import 'package:flutter/material.dart';

//Comprobamos con una expresión regular si el texto es un email
bool isAEmail(String email){
  Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = RegExp(pattern);
  return regExp.hasMatch(email);
}

//Para mostrar alertas en la aplicación
void showAlert(BuildContext context, List<Widget> actions, String titulo, String contenido){
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context){
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
        title: Text(titulo),
        content: Text(contenido),
        actions: actions,
      );
    }
  );
}