import 'dart:convert';

Publicacion publicacionFromJson(String str) => Publicacion.fromJson(json.decode(str));

String publicacionToJson(Publicacion data) => json.encode(data.toJson());

class Publicacion {

  String idPublicacion;
  String foto;
  String idUsuario;
  double latitud;
  double longitud;
  int meGustas;
  String titulo;

  Publicacion({
    this.idPublicacion,
    this.foto,
    this.idUsuario,
    this.latitud,
    this.longitud,
    this.meGustas,
    this.titulo,
  });
 
  factory Publicacion.fromJson(Map<String, dynamic> json) => Publicacion(
    idPublicacion   : json["idPublicacion"],
    foto            : json["foto"],
    idUsuario       : json["idUsuario"],
    latitud         : json["latitud"].toDouble(),
    longitud        : json["longitud"].toDouble(),
    meGustas        : json["meGustas"],
    titulo          : json["titulo"],
  );

  Map<String, dynamic> toJson() => {
    "idPublicacion"   : idPublicacion,
    "foto"            : foto,
    "idUsuario"       : idUsuario,
    "latitud"         : latitud,
    "longitud"        : longitud,
    "meGustas"        : meGustas,
    "titulo"          : titulo,
  };
}
