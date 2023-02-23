import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_grupo4/models/products.dart';
import 'package:flutter_grupo4/services/services.dart';
import 'package:http/http.dart' as http;

class ProductService extends ChangeNotifier {
  final String _baseUrl = 'localhost:8080';
  bool isLoading = true;
  final List<Products> allProducts = [];

  getProducts() async {
    allProducts.clear();
    final url = Uri.http(_baseUrl, '/api/products');
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
        allProducts.add(Products.fromJson(i));
      }
      isLoading = false;
      notifyListeners();
      return allProducts;
    }
  }

  deletProduct(int id) async {
    final url = Uri.http(_baseUrl, '/api/products/$id');
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

  createNewProduct(
      String nombre, String descripcion, double precio, int idCategoria) async {
    final Map<String, dynamic> productData = {
      'nombre': nombre,
      'descripcion': descripcion,
      'precio': precio,
    };
    final url = Uri.http(_baseUrl, '/api/categories/$idCategoria/product');
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
    if (jsonDecode(resp.body) == []) {
    } else {
      print(resp.body);
      isLoading = false;
      notifyListeners();
      return allProducts;
    }
  }
}
