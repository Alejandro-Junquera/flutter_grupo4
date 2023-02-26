import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_grupo4/models/products.dart';
import 'package:flutter_grupo4/services/services.dart';
import 'package:http/http.dart' as http;

class ProductService extends ChangeNotifier {
  final String _baseUrl = 'localhost:8080';
  bool isLoading = true;
  final List<Products> allProducts = [];
  final List<Products> allFavourites = [];
  Products? product;

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

  getProductById(int id) async {
    final url = Uri.http(_baseUrl, '/api/products/$id');
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
    product = Products(
        id: decodedResp['id'],
        nombre: decodedResp['nombre'],
        descripcion: decodedResp['descripcion'],
        precio: decodedResp['precio'],
        categoriaId: decodedResp['categoria']);
  }

  updateProduct(int id, String nombre, String descripcion, double precio,
      int idCategoria) async {
    final Map<String, dynamic> productData = {
      'id': id,
      'nombre': nombre,
      'descripcion': descripcion,
      'precio': precio,
      'categoriaId': idCategoria,
    };
    final url = Uri.http(_baseUrl, '/api/products');
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
    return allProducts;
  }

  allFavouriteProducts() async {
    allFavourites.clear();
    String? id = await AuthService().readId();
    final url = Uri.http(_baseUrl, '/users/$id/favoritos');
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
        allFavourites.add(Products.fromJson(i));
      }
      isLoading = false;
      notifyListeners();
      return allFavourites;
    }
  }

  newFavouriteProduct(int idProduct) async {
    String? token = await AuthService().readToken();
    String? id = await AuthService().readId();
    final url = Uri.http(_baseUrl, '/api/users/$id/favoritos/$idProduct');
    isLoading = true;
    notifyListeners();
    final resp = await http.post(
      url,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "Authorization": token!
      },
    );
  }

  filterByCategory(int category) async {
    allProducts.clear();
    final url = Uri.http(_baseUrl, '/api/categories/$category/products');
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
}
