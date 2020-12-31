import 'package:flutter/material.dart';
import 'package:instadroid/src/models/publicacion_model.dart';
import 'package:instadroid/src/providers/publicaciones_provider.dart';
import 'package:instadroid/src/providers/upload_photo_provider.dart' as StorageUtil;
import 'package:instadroid/src/providers/user_preferences.dart';
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

  //Variable de estado
  bool _cargando;

  //La publicación que vamos a ir construyendo para subir
  Publicacion publicacion = Publicacion();

  //Imagen de la cámara o de la galería
  File imagen;

  final formKey = GlobalKey<FormState>();
  @override
  void initState() { 
    super.initState();
    _cargando = false;
  }

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
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _createPhotoLayout(context),
              SizedBox(height: 15.0),
              _createTitleInput(),
              SizedBox(height: 10.0),
              _createUploadPhotoButton(context),
              SizedBox(height: 15.0),
              _createCancelButton(context),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera),
        onPressed: () => utils.showAlert(
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
        backgroundColor: myTheme.buttonColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }

  Widget _createPhotoLayout(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    if(imagen != null){
      return Container(
          width: double.infinity,
          height: screenSize.height * 0.5,
          child: Image.file(
            imagen,
            fit: BoxFit.cover,
          ),
        );
    }else{
      return Container(
        width: double.infinity,
        height: screenSize.height * 0.38,
        child: Image(
          image: AssetImage('assets/img/photoupload.gif'),
        ),
      );
    }
  }
  
  Widget _createTitleInput() {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(255,255,255, 0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.symmetric(horizontal: 35, vertical: 6),
      child: TextFormField(
        minLines: 3,
        maxLines: 10,
        decoration: InputDecoration(
          icon: Icon(Icons.photo_album, color: myTheme.buttonColor, size: 30.0),
          labelText: 'titulo',
          labelStyle: TextStyle(
            color: myTheme.buttonColor,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0)
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(
              color: myTheme.buttonColor,
              width: 2.0,
            ),
          ),  
        ),
        onSaved: (value) => publicacion.titulo = value,
        validator: (value){
          if(value.length > 0){
            return null;
          }else{
            return 'El título debe contener al menos un caracter';
          }
        }
      ),
    );
  }

  Widget _createUploadPhotoButton(BuildContext context) {
    if(!_cargando){
      return Container(
        width: 300,
        child: RaisedButton(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal:80.0, vertical: 15.0),
            child: Text('Subir foto'),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          elevation: 0.0, 
          color: myTheme.buttonColor,
          textColor: Colors.white,
          onPressed: () => _submit(context),
        ),
      );
    }else{
      return CircularProgressIndicator(backgroundColor: myTheme.primaryColor);
    }
  }

  Widget _createCancelButton(BuildContext context) {
    return Container(
      width: 300,
      child: RaisedButton(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal:80.0, vertical: 15.0),
          child: Text('Cancelar'),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 0.0, 
        color: Colors.red,
        textColor: Colors.white,
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }

  //Gestión de imágenes cámara/galería
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
    setState(() {});
  }

  //Procesamiento del formulario
  void _submit(BuildContext context) async {
    if(!formKey.currentState.validate()){
      return;
    }
    if(imagen == null){
      utils.showAlert(
        context, 
          [
            FlatButton(
              child: Text('Ok'),
              onPressed: (){
                Navigator.of(context).pop();
              } 
            ),
          ], 
        'Subir foto', 
        'Por favor, inserta una imagen',
      );
      return;
    }
    formKey.currentState.save();
  
    final publicacionesProvider = PublicacionesProvider();
    final prefs = UserPreferences();
    //Subimos la imagen a firebase storage
    setState(() {
      _cargando = true;
    });
    publicacion.foto = await StorageUtil.uploadImageToFirebase(imagen, publicacion.titulo);

    //Le añadimos la id del usuario que la está subiendo que está en shared prefs
    publicacion.idUsuario = prefs.idUsuarioLogueado;
    //Establecemos los me gusta a 0
    publicacion.meGustas = 0;
    //De momento inventamos latitud y longitud
    publicacion.latitud  = 34234.23423;
    publicacion.longitud = 334134.1234;
    //Con todos los datos subimos la foto a realtime database de firebase
    bool publiSubida = await publicacionesProvider.insertarPublicacion(publicacion);
    setState(() {
      _cargando = false;
    });
    Navigator.pushReplacementNamed(context,'home');
  }
}