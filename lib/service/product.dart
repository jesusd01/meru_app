import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:meru_app/global/environment.dart';
import 'package:meru_app/models/product.dart';

class FetchTable {
  Future<List<Product>> getProducts() async {
    final res = await http
        .get(Uri.parse('${Environment.api}products'))
        .timeout(const Duration(seconds: 20));
    if (res.statusCode == 200) {
      final products = productFromJson(res.body);
      return products;
    } else {
      return [];
    }
  }
}
