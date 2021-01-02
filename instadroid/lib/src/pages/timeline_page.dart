import 'package:flutter/material.dart';
import 'package:instadroid/src/models/publicacion_model.dart';
import 'package:instadroid/src/models/usuario_model.dart';
import 'package:instadroid/src/providers/publicaciones_provider.dart';
import 'package:instadroid/src/providers/user_preferences.dart';
import 'package:instadroid/src/providers/user_provider.dart';
import 'package:instadroid/src/theme/mytheme.dart';
import 'package:instadroid/src/utils/utils.dart' as utils;

class TimelinePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _PublicacionesList(),
    );
  }
}

class _PublicacionesList extends StatelessWidget {

  final publicacionesProvider = PublicacionesProvider();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: publicacionesProvider.listarPublicaciones(),
      builder: (BuildContext context, AsyncSnapshot<List<Publicacion>> snapshot) {
        if(snapshot.hasData){
          return ListView.builder(
          itemCount: snapshot.data.length, 
          itemBuilder: (context, index) => _PublicacionItem(publicacion: snapshot.data[index]),
          );
        }else{
          return Container(
            height: 400.0,
            child: Center(
              child: CircularProgressIndicator(
                backgroundColor: myTheme.primaryColor,
              ),
            ),
          );
        } 
      },
    );
  }
}

class _PublicacionItem extends StatelessWidget {

  final Publicacion publicacion;

  const _PublicacionItem({@required this.publicacion});

  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: EdgeInsets.symmetric(horizontal:15.0, vertical: 20.0),
      child: Column(
        children: [
          _PublicacionItemHeader(publicacion: this.publicacion),
          SizedBox(height: 10),
          _PublicacionImagen(publicacion: this.publicacion),
          SizedBox(height: 0.0),
          _PublicacionActions(publicacion: this.publicacion),
          SizedBox(height: 5.0),
          _PublicacionTitulo(publicacion: this.publicacion),
          SizedBox(height:20.0),
          Divider(thickness: 1.0),
        ],
      ),
    );
  }
}

class _PublicacionItemHeader extends StatelessWidget {

  final Publicacion publicacion;

  const _PublicacionItemHeader({@required this.publicacion});

  @override
  Widget build(BuildContext context) { 
    final usuariosProvider = UserProvider();
    return FutureBuilder(
      future: usuariosProvider.findUserById(publicacion.idUsuario),
      builder: (BuildContext context, AsyncSnapshot<Usuario> snapshot) {
        if(snapshot.hasData){
          return Container(
            padding: EdgeInsets.symmetric(horizontal:10.0, vertical: 10.0),
            child: Row(
              children: [
                CircleAvatar(
                  child: Text('CG'),
                  backgroundColor: myTheme.buttonColor,
                  foregroundColor: Colors.white,
                  maxRadius: 15.0,
                ),
                SizedBox(width: 10.0),
                Text(
                  snapshot.data.nombreUsuario, 
                  style: TextStyle(fontSize: 18)
                ), 
              ],
            ),
          );
        }else{
          return Row(
            children: [
              CircleAvatar(
                child: Text('ID'),
                backgroundColor: myTheme.buttonColor,
                foregroundColor: Colors.white,
                maxRadius: 15.0,
              ),
              SizedBox(width: 10.0),
              Text(
                'Usuario', 
                style: TextStyle(fontSize: 18)
              ), 
            ],
          );
        } 
      },
    );
  }
}

class _PublicacionImagen extends StatelessWidget {

  final Publicacion publicacion;

  const _PublicacionImagen({@required this.publicacion});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 250.0,
      child: FadeInImage(
        placeholder: AssetImage('assets/img/loading.gif'),
        image: NetworkImage(publicacion.foto),
        fit: BoxFit.cover,
      ),
    );
  }
}

class _PublicacionActions extends StatefulWidget {

  final Publicacion publicacion;

  const _PublicacionActions({@required this.publicacion});

  @override
  __PublicacionActionsState createState() => __PublicacionActionsState(this.publicacion);
}

class __PublicacionActionsState extends State<_PublicacionActions> {

  bool _isLiked;
  final _prefs = UserPreferences();
  final Publicacion publicacion;

  __PublicacionActionsState(this.publicacion);

  @override
  void initState() {
    super.initState();
    _isLiked = false;
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _createLikeButton(),
        _createPositionButton(context),
        Expanded(
          child: Container(),
        ),
        //Si la publicación la hemos subido el usuario logueado, se muestran las opciones de
        //editar y eliminar
        (_prefs.idUsuarioLogueado == publicacion.idUsuario)
          ? _createEditButton()
          : Container(),
        (_prefs.idUsuarioLogueado == publicacion.idUsuario)
          ? _createDeleteButton(publicacion.idPublicacion, context)
          : Container(),
      ],   
    );
  }

  Widget _createLikeButton() {
    return IconButton(
      icon: (_isLiked) 
        ? Icon(Icons.favorite)
        : Icon(Icons.favorite_border),
      onPressed: () {
        setState(() {
          _isLiked = !_isLiked;
        });
      },
      color: (_isLiked)
        ? Colors.red
        : Colors.grey,
      iconSize: 30,
    );
  }

  Widget _createPositionButton(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.location_pin, color: Colors.grey),
      onPressed: () {
        //Navegación a la pantalla de localización
        Navigator.pushNamed(context, 'localizacion', arguments: publicacion);
      },
      iconSize: 30,
    );
  }

  _createDeleteButton(String idPublicacion, BuildContext context) {
    return IconButton(
      icon: Icon(Icons.delete, color: Colors.grey),
      onPressed: () {
        utils.showAlert(
          context,
          [
            FlatButton(
              child: Text('Aceptar'),
              onPressed: () async{
                //Eliminamos la publicación
                final publicacionesProvider = PublicacionesProvider();
                bool publiEliminada = await publicacionesProvider.borrarPublicacion(idPublicacion);
                if(publiEliminada){
                  Navigator.of(context).pop();
                  Navigator.pushNamed(context, 'home');
                }
              } 
            ),
            FlatButton(
              child: Text('Cancelar'),
              onPressed: () => Navigator.of(context).pop(),
            )
          ], 
          'Borrar publicación', 
          '¿Seguro/a de borrar la publicación?',
        );
      },
      iconSize: 30,
    );
  }

  _createEditButton() {
    return IconButton(
      icon: Icon(Icons.edit, color: Colors.grey),
      onPressed: (){
        //Editamos la publicación
      },
      iconSize: 30,
    );
  }
}

class _PublicacionTitulo extends StatelessWidget {

  final Publicacion publicacion;

  const _PublicacionTitulo({@required this.publicacion});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      alignment: Alignment.bottomLeft,
      child: Text(
        publicacion.titulo,
        style: TextStyle(
          fontSize: 18
        ),
      ),
    );
  }
}