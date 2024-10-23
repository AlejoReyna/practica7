// lib/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ApiService {
  static const String baseUrl = 'https://fakestoreapi.com';

  static Future<List<Product>> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/products'));

      if (response.statusCode == 200) {
        List<dynamic> productsJson = json.decode(response.body);
        
        // Convertimos los datos de FakeStoreAPI al formato de nuestro modelo Product
        List<Product> products = productsJson.map((json) => Product(
          name: json['title'], // FakeStoreAPI usa 'title' en lugar de 'name'
          price: (json['price'] as num).toDouble(), // Convertimos el precio a double
          imageUrl: json['image'], // FakeStoreAPI usa 'image' que coincide con nuestro modelo
        )).toList();
        
        return products;
      } else {
        throw Exception('Error al cargar productos: ${response.statusCode}');
      }
    } catch (e) {
      print('Error detallado: $e'); // Para debugging
      throw Exception('Error de conexión: $e');
    }
  }

  // Método de respaldo con datos mockeados en caso de que la API falle
  static Future<List<Product>> getMockProducts() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      Product(
        name: 'Fjallraven Backpack',
        price: 109.95,
        imageUrl: 'https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg',
      ),
      Product(
        name: 'Mens T-Shirt',
        price: 22.99,
        imageUrl: 'https://fakestoreapi.com/img/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_.jpg',
      ),
      Product(
        name: 'Mens Cotton Jacket',
        price: 55.99,
        imageUrl: 'https://fakestoreapi.com/img/71li-ujtlUL._AC_UX679_.jpg',
      ),
    ];
  }
}