// lib/services/api_service.dart
import 'dart:convert';
import 'dart:isolate';
import 'package:http/http.dart' as http;
import '../models/product.dart';

Future<List<Product>> fetchProducts() async {
  ReceivePort receivePort = ReceivePort();
  await Isolate.spawn(_fetchProductsInIsolate, receivePort.sendPort);
  return await receivePort.first;
}

void _fetchProductsInIsolate(SendPort sendPort) async {
  final response = await http.get(Uri.parse('https://api.ejemplo.com/products'));
  if (response.statusCode == 200) {
    List<Product> products = (json.decode(response.body) as List)
        .map((data) => Product.fromJson(data))
        .toList();
    sendPort.send(products);
  } else {
    throw Exception('Error al cargar productos');
  }
}