import 'dart:convert';

Usuario usuarioFromJson(String str) => Usuario.fromJson(json.decode(str));

String usuarioToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
    
  String idFire;
  String nombreUsuario;
  String email;
  String password;
  String fotoUrl;
  String tokenAuth;

  Usuario({
    this.idFire,
    this.nombreUsuario,
    this.email,
    this.password,
    this.fotoUrl,
    this.tokenAuth,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
    idFire          : json["idFire"],
    nombreUsuario   : json["nombreUsuario"],
    email           : json["email"],
    fotoUrl         : json["fotoUrl"],
  );

  Map<String, dynamic> toJson() => {
    "nombreUsuario"   : nombreUsuario,
    "email"           : email,
    "fotoUrl"         : fotoUrl,
  };
}
