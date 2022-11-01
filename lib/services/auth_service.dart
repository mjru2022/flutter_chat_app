import 'dart:convert';

//import 'package:chat/global/enviroment.dart';
import 'package:chat/global/enviroment.dart';
import 'package:chat/models/login_response.dart';
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/usuarios.dart';

class AuthService with ChangeNotifier {
  late Usuario usuario;
  bool _autenticando = false;
  bool get autenticando => this._autenticando;
  // Create storage
  final _storage = new FlutterSecureStorage();
  set autenticando(bool valor) {
    this._autenticando = valor;
    notifyListeners();
  }

  //Getters del token de forma estatica
  static Future<String?> getToken() async {
    final _storage = new FlutterSecureStorage();
    final token = await _storage.read(key: "token");
    return token;
  }

  //Getters del token de forma estatica
  static Future<void> deleteToken() async {
    final _storage = new FlutterSecureStorage();
    await _storage.delete(key: "token");
  }

  //late Usuario usuario;
  Future<bool?> login(String email, String password) async {
    this.autenticando = true;
    final data = {"email": email, "password": password};
    final resp = await http.post(Uri.parse("${Environment.apiUrl}/login"),
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    this.autenticando = false;
    if (resp.statusCode == 200) {
      final loginResponse = loginResposeFromJson(resp.body);
      this.usuario = loginResponse.usuario;
      await this._guardarToken(loginResponse.token);

      return true;
    } else {
      return false;
    }
  }

  Future register(String nombre, String email, String password) async {
    this.autenticando = true;
    final data = {"nombre": nombre, "email": email, "password": password};
    final resp = await http.post(Uri.parse("${Environment.apiUrl}/login/new"),
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    this.autenticando = false;
    if (resp.statusCode == 200) {
      final loginResponse = loginResposeFromJson(resp.body);
      this.usuario = loginResponse.usuario;
      await this._guardarToken(loginResponse.token);

      return true;
    } else {
      final respBody = jsonDecode(resp.body);
      return respBody['msg'];
    }
  }

  Future<bool?> isLoggedIn() async {
    final token = await this._storage.read(key: "token");
    final resp = await http.get(Uri.parse("${Environment.apiUrl}/login/renew"),
        headers: {'Content-Type': 'application/json', "x-token": token!});

    if (resp.statusCode == 200) {
      final loginResponse = loginResposeFromJson(resp.body);
      this.usuario = loginResponse.usuario;
      await this._guardarToken(loginResponse.token);

      return true;
    } else {
      this.logout();
      return false;
      //final respBody = jsonDecode(resp.body);
      //return respBody['msg'];
    }
  }

  //metodo para guarda token
  Future _guardarToken(String token) async {
    return await _storage.write(key: "token", value: token);
  }

  Future logout() async {
    return await _storage.delete(key: "token");
  }
}
