import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_grupo4/models/models.dart';
import 'package:flutter_grupo4/services/services.dart';
import 'package:http/http.dart' as http;

class CategoryService extends ChangeNotifier {
  final String _baseUrl = 'localhost:8080';
  bool isLoading = true;
  final List<Categories> allCategories = [];
  Categories? category;

  getCategories() async {
    allCategories.clear();
    final url = Uri.http(_baseUrl, '/api/categories');
    String? token = await AuthService().readToken();
    isLoading = true;
    notifyListeners();
    final resp = await http.get(
      url,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "Authorization": token!
      },
    );
    if (jsonDecode(resp.body) == []) {
    } else {
      final List<dynamic> decodedResp = json.decode(resp.body);
      for (var i in decodedResp) {
        allCategories.add(Categories.fromJson(i));
      }
      isLoading = false;
      notifyListeners();
      return allCategories;
    }
  }

  deletCategory(int id) async {
    final url = Uri.http(_baseUrl, '/api/categories/$id');
    String? token = await AuthService().readToken();
    isLoading = true;
    notifyListeners();
    final resp = await http.delete(
      url,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "Authorization": token!
      },
    );
  }

  deletAllProductsFromCategory(int id) async {
    final url = Uri.http(_baseUrl, '/api/categories/$id/products');
    String? token = await AuthService().readToken();
    isLoading = true;
    notifyListeners();
    final resp = await http.delete(
      url,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "Authorization": token!
      },
    );
  }

  updateCategory(int id, String nombre, String descripcion) async {
    final Map<String, dynamic> productData = {
      'id': id,
      'nombre': nombre,
      'descripcion': descripcion,
    };
    final url = Uri.http(_baseUrl, '/api/categories');
    String? token = await AuthService().readToken();
    isLoading = true;
    notifyListeners();
    final resp = await http.put(url,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          "Authorization": token!
        },
        body: json.encode(productData));

    print(resp.body);
    isLoading = false;
    notifyListeners();
    return allCategories;
  }

  getCategoryById(int id) async {
    final url = Uri.http(_baseUrl, '/api/categories/$id');
    String? token = await AuthService().readToken();
    isLoading = true;
    notifyListeners();
    final resp = await http.get(
      url,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "Authorization": token!
      },
    );
    final Map<String, dynamic> decodedResp = json.decode(resp.body);
    category = Categories(
      id: decodedResp['id'],
      nombre: decodedResp['nombre'],
      descripcion: decodedResp['descripcion'],
    );
  }

  createNewCategory(
      String nombre, String descripcion, List<dynamic> productos) async {
    final Map<String, dynamic> productData = {
      'nombre': nombre,
      'descripcion': descripcion,
      'productos': productos,
    };
    final url = Uri.http(_baseUrl, '/api/categories');
    String? token = await AuthService().readToken();
    isLoading = true;
    notifyListeners();
    final resp = await http.post(url,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          "Authorization": token!
        },
        body: json.encode(productData));
    isLoading = false;
    notifyListeners();
    return allCategories;
  }
}
