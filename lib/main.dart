import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_meat_gastronom/features/cart/cart_model.dart';
import 'package:test_meat_gastronom/features/recomended_products_screen/recomended_product_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CartModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Рекомендации',
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: const RecommendedProductsScreen(),
    );
  }
}


