import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

Future<void> sendEmail(String recipientEmail, double total) async {
  String username = 'tu_correo@gmail.com'; // Cambia esto con tu correo
  String password = 'tu_contraseña'; // Cambia esto con tu contraseña

  final smtpServer = gmail(username, password);

  final message = Message()
    ..from = Address(username, 'Tu Tienda')
    ..recipients.add(recipientEmail) // Correo del destinatario
    ..subject = 'Tu Ticket de Compra'
    ..text = 'Gracias por tu compra. El total es \$${total.toStringAsFixed(2)}';

  try {
    final sendReport = await send(message, smtpServer);
    print('Mensaje enviado: ' + sendReport.toString());
  } catch (e) {
    print('Error al enviar el mensaje: $e');
  }
}