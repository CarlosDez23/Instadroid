import 'dart:convert';

Usuario usuarioFromJson(String str) => Usuario.fromJson(json.decode(str));

String usuarioToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
    
  String idFire;
  String nombreUsuario;
  String email;
  String password;
  String fotoUrl;

  Usuario({
    this.idFire,
    this.nombreUsuario,
    this.email,
    this.password,
    this.fotoUrl,
  });

  //Aquí si tenemos el id porque firebase nos lo mandará con id
  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
    idFire          : json["idFire"],
    nombreUsuario   : json["nombreUsuario"],
    email           : json["email"],
    fotoUrl         : json["fotoUrl"],
  );

  //Cuando mapeamos a Json es para enviarlo a firebase y en firebase solo queremos tener estos datos
  Map<String, dynamic> toJson() => {
    "nombreUsuario"   : nombreUsuario,
    "email"           : email,
    "fotoUrl"         : fotoUrl,
  };
}
