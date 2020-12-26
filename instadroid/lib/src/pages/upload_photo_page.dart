import 'package:flutter/material.dart';
import 'package:instadroid/src/theme/mytheme.dart';

class UploadPhotoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Subir foto'),
      ),
      floatingActionButton: FloatingActionButton( 
        child: Icon(Icons.arrow_left, color: Colors.white),
        backgroundColor: myTheme.buttonColor,
        onPressed: () => Navigator.pop(context),
      )
    );
  }
}