import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// ignore: depend_on_referenced_packages
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService extends ChangeNotifier {
  final String _baseUrl = 'semillero.allsites.es';
  final storage = const FlutterSecureStorage();
  bool isLoading = true;
  String mensaje = '';

  readToken() async {
    return await storage.read(key: 'token') ?? '';
  }

  readId() async {
    return await storage.read(key: 'id') ?? '';
  }

  Future<String?> login(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password
    };

    final url = Uri.http(_baseUrl, '/public/api/login', {});
    final resp = await http.post(url,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          "Authorization": "Some token"
        },
        body: json.encode(authData));
    final Map<String, dynamic> decodedResp = json.decode(resp.body);
    if (decodedResp['success'] == true) {
      await storage.write(key: 'token', value: decodedResp['data']['token']);
      await storage.write(
          key: 'id', value: decodedResp['data']['id'].toString());
      return decodedResp['data']['type'] +
          ',' +
          decodedResp['data']['actived'].toString() +
          ',' +
          decodedResp['data']['deleted'].toString();
    } else {
      return decodedResp['message'];
    }
  }

  Future<String?> register(String name, String surname, String email,
      String password, String cPassword, int cicleId) async {
    final Map<String, dynamic> authData = {
      'firstname': name,
      'secondname': surname,
      'email': email,
      'password': password,
      'c_password': cPassword,
      'company_id': cicleId,
    };
    final url = Uri.http(_baseUrl, '/public/api/register', {});

    final resp = await http.post(url,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          "Authorization": "Some token"
        },
        body: json.encode(authData));
    final Map<String, dynamic> decodedResp = json.decode(resp.body);

    if (decodedResp['success'] == true) {
      await storage.write(key: 'token', value: decodedResp['data']['token']);
      await storage.write(
          key: 'name', value: decodedResp['data']['firstname'].toString());
      //String id = decodedResp['data']['id'].toString();
      //VerifyService().isVerify(id);
    } else {
      return decodedResp['message'];
    }
    return null;
  }

  Future logout() async {
    await storage.deleteAll();
    return;
  }
}
