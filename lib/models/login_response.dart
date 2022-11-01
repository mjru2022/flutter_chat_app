// To parse this JSON data, do
//
//     final loginRespose = loginResposeFromJson(jsonString);

import 'dart:convert';

import 'package:chat/models/usuarios.dart';

LoginRespose loginResposeFromJson(String str) =>
    LoginRespose.fromJson(json.decode(str));

String loginResposeToJson(LoginRespose data) => json.encode(data.toJson());

class LoginRespose {
  LoginRespose({
    required this.ok,
    required this.usuario,
    required this.token,
  });

  bool ok;
  Usuario usuario;
  String token;

  factory LoginRespose.fromJson(Map<String, dynamic> json) => LoginRespose(
        ok: json["ok"],
        usuario: Usuario.fromJson(json["usuario"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "usuario": usuario.toJson(),
        "token": token,
      };
}
