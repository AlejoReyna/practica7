// test/widget_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:newproject/main.dart';
import 'package:newproject/services/api_service.dart';
import 'package:newproject/models/product.dart';

void main() {
  testWidgets('App shows product gallery', (WidgetTester tester) async {
    // Build our app and trigger a frame
    await tester.pumpWidget(const MyApp());

    // Verify that we have a product gallery
    expect(find.byType(ProductGallery), findsOneWidget);

    // Allow the future to complete
    await tester.pumpAndSettle();

    // Verify that we have products displayed
    expect(find.byType(ProductItem), findsWidgets);
  });

  testWidgets('Cart icon shows and can be tapped', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Verify that we have a cart icon
    expect(find.byIcon(Icons.shopping_cart), findsOneWidget);

    // Tap the cart icon
    await tester.tap(find.byIcon(Icons.shopping_cart));
    await tester.pumpAndSettle();

    // Verify that we navigate to the cart screen
    expect(find.byType(CartScreen), findsOneWidget);
  });
}