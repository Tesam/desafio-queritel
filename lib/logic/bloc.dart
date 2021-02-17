import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:desafio_queritel/utils/constans.dart';
import 'package:desafio_queritel/models/product.dart';

class Block extends ChangeNotifier {
  List<Product> products = [];

  Future<void> requestProducts() async {
    final response = await http.get(
      api_queritel,
    );
    final data = jsonDecode(response.body);
    var rest = data["item_list"] as List;
    products = rest.map((json) => Product.fromJson(json)).toList();
    notifyListeners();
  }
}
