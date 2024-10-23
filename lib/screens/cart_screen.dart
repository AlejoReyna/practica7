import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../models/product.dart';
import '../services/email_service.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Carrito de Compras'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (context, index) {
                Product product = cart.items[index];
                return ListTile(
                  leading: Image.network(product.imageUrl, width: 50),
                  title: Text(product.name),
                  trailing: Text('\$${product.price.toStringAsFixed(2)}'),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Total: \$${cart.totalPrice.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              // Simular el pago y enviar el correo
              String email = 'cliente@ejemplo.com'; // Aquí pondrías el correo del cliente
              double total = cart.totalPrice;

              // Enviar el correo
              await sendEmail(email, total);

              // Mostrar confirmación
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Pago Exitoso'),
                  content: Text('El total de \$${total.toStringAsFixed(2)} ha sido enviado a $email.'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Aceptar'),
                    ),
                  ],
                ),
              );

              // Limpiar el carrito
              cart.clearCart();
            },
            child: Text('Realizar Pago'),
          ),
        ],
      ),
    );
  }
}