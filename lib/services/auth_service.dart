import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// ignore: depend_on_referenced_packages
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService extends ChangeNotifier {
  final String _baseUrl = 'localhost:8080';
  final storage = const FlutterSecureStorage();
  bool isLoading = true;
  String mensaje = '';

  readToken() async {
    return await storage.read(key: 'token') ?? '';
  }

  readId() async {
    return await storage.read(key: 'id') ?? '';
  }

  Future<String?> login(String username, String password) async {
    final Map<String, dynamic> authData = {
      'username': username,
      'password': password
    };

    final url = Uri.http(_baseUrl, 'login', {});
    final resp = await http.post(url,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          "Authorization": "Some token"
        },
        body: json.encode(authData));
    final Map<String, dynamic> decodedResp = json.decode(resp.body);
    if (decodedResp['status'] == 403) {
      return 'Password or user incorrect';
    } else {
      await storage.write(key: 'token', value: decodedResp['token']);
      await storage.write(key: 'id', value: decodedResp['id'].toString());
      return decodedResp['role'];
    }
  }

  Future<String?> register(String username, String password) async {
    final Map<String, dynamic> authData = {
      'username': username,
      'password': password,
    };
    final url = Uri.http(_baseUrl, 'register', {});

    final resp = await http.post(url,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          "Authorization": "Some token"
        },
        body: json.encode(authData));
    final Map<String, dynamic> decodedResp = json.decode(resp.body);
    if (decodedResp['status'] == 500) {
      return 'User name already exist';
    } else {}
    return null;
  }

  Future logout() async {
    await storage.deleteAll();
    return;
  }
}
