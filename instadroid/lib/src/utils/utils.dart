import 'package:flutter/material.dart';

bool isAEmail(String email){
  Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = RegExp(pattern);
  return regExp.hasMatch(email);
}

void showAlert(BuildContext context, List<Widget> actions, String titulo, String contenido){
  showDialog(
    context: context,
    barrierDismissible: false,
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