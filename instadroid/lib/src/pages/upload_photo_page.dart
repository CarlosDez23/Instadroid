import 'package:flutter/material.dart';
import 'package:instadroid/src/theme/mytheme.dart';
import 'package:instadroid/src/widgets/app_title.dart';
import 'package:instadroid/src/utils/utils.dart' as utils;
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class UploadPhotoPage extends StatefulWidget {

  @override
  _UploadPhotoPageState createState() => _UploadPhotoPageState();
}

class _UploadPhotoPageState extends State<UploadPhotoPage> {
  File imagen;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Transform(
          transform:  Matrix4.translationValues(-100.0, 0.0, 0.0),
          child: AppTitle(
            color: Colors.black,
            size: 35.0
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _createPhotoLayout(context),
        ],
      ),
      floatingActionButton: FloatingActionButton( 
        child: Icon(Icons.vertical_align_top, color: Colors.white),
        backgroundColor: myTheme.buttonColor,
        onPressed: () => Navigator.pop(context),
      )
    );
  }

  Widget _createPhotoLayout(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    if(imagen != null){
      return GestureDetector(
        child: Container(
          width: double.infinity,
          height: screenSize.height * 0.5,
          child: Image.file(
            imagen,
            fit: BoxFit.cover,
          ),
        ),
        onTap: () => utils.showAlert(
          context, 
          [
            FlatButton(
              child: Text('Cámara'),
              onPressed: (){
                Navigator.of(context).pop();
                _takePhoto();
              } 
            ),
            FlatButton(
              child: Text('Galería'),
              onPressed: (){
                Navigator.of(context).pop();
                _pickPhotoFromGallery();  
              } 
            ),
          ], 
          'Subir foto', 
          'Elige un método de subida',
        )
      );
    }else{
      return GestureDetector(
        child: Container(
          width: double.infinity,
          height: screenSize.height * 0.38,
          child: Image(
            image: AssetImage('assets/img/photoupload.gif'),
          ),
        ),
        onTap: () => utils.showAlert(
          context, 
          [
            FlatButton(
              child: Text('Cámara'),
              onPressed: (){
                Navigator.of(context).pop();
                _takePhoto();
              } 
            ),
            FlatButton(
              child: Text('Galería'),
              onPressed: (){
                Navigator.of(context).pop();
                _pickPhotoFromGallery();
              } 
            ),
          ], 
          'Subir foto', 
          'Elige un método de subida',
        ),
      );
    }
  }

  _pickPhotoFromGallery() async{
    _handleImage(ImageSource.gallery);
  }
  _takePhoto() async{
    _handleImage(ImageSource.camera);
  }

  _handleImage(ImageSource origen) async{
    imagen = await ImagePicker.pickImage(
      source: origen
    );
    if(imagen != null){
      //Quitamos la imagen anterior
      // producto.fotoUrl = null;
    }
    setState(() {});
  }
}