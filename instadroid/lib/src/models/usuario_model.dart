import 'dart:convert';

Usuario usuarioFromJson(String str) => Usuario.fromJson(json.decode(str));

String usuarioToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
    
  String idFire;
  String nombreUsuario;
  String email;
  String password;
  String tokenAuth;

  Usuario({
    this.idFire,
    this.nombreUsuario,
    this.email,
    this.password,
    this.tokenAuth,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
    idFire          : json["idFire"],
    nombreUsuario   : json["nombreUsuario"],
    email           : json["email"],
    password        : json["password"],
    tokenAuth       : json["tokenAuth"],
  );

  Map<String, dynamic> toJson() => {
    "idFire"          : idFire,
    "nombreUsuario"   : nombreUsuario,
    "email"           : email,
    "password"        : password,
    "tokenAuth"       : tokenAuth,
  };
}
