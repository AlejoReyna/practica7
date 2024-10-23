import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  ProductItem({required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Image.network(product.imageUrl, height: 120),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(product.name),
          ),
          Text('\$${product.price.toStringAsFixed(2)}'),
          ElevatedButton(
            onPressed: () {
              Provider.of<CartProvider>(context, listen: false).addItem(product);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Agregado al carrito'),
                duration: Duration(seconds: 1),
              ));
            },
            child: Text('Agregar al carrito'),
          ),
        ],
      ),
    );
  }
}