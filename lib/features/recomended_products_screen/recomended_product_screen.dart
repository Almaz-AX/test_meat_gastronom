import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_meat_gastronom/features/cart/cart_bottom_sheet.dart';
import 'package:test_meat_gastronom/features/cart/cart_model.dart';
import 'package:test_meat_gastronom/features/models/product.dart';
import 'package:test_meat_gastronom/features/recomended_products_screen/widgets/product_card.dart';

class RecommendedProductsScreen extends StatelessWidget {
  const RecommendedProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final recommendedProducts = [
      Product(
        id: '1',
        name: 'Молоко Простоквашино',
        price: 89.90,
        imageUrl: 'https://magasmarket.ru/upload/iblock/48d/48d0f748804b8e428a0fe05bf88e4991.jpeg',
      ),
      Product(
        id: '2',
        name: 'Хлеб Бородинский',
        price: 45.50,
        imageUrl: 'https://main-cdn.sbermegamarket.ru/big2/hlr-system/-13/716/698/141/031/130/100029549198b0.jpg',
      ),
      Product(
        id: '3',
        name: 'Яйца куриные',
        price: 99.00,
        imageUrl: 'https://24rus.ru/images/2021/egg-2759291_1280.jpg',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        title: const Text('Добавьте в заказ'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: recommendedProducts.length,
              itemBuilder: (context, index) {
                final product = recommendedProducts[index];
                return Consumer<CartModel>(
                  builder: (context, cart, child) {
                    final isAdded = cart.isProductInCart(product);
                    return ProductCard(
                      product: product,
                      isAdded: isAdded,
                      onAddPressed: () {
                        if (!isAdded) {
                          cart.addProduct(product);
                        } else {
                          cart.removeProduct(product);
                        }
                      },
                    );
                  },
                );
              },
            ),
          ),
          Consumer<CartModel>(
            builder: (context, cart, child) {
              if (cart.totalItems == 0) {
                return const SizedBox.shrink();
              }
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 8,
                      offset: const Offset(0, -2),
                    ),
                  ],
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                ),
                child: SafeArea(
                  child: InkWell(
                    onTap: () => _showCartBottomSheet(context),
                    child: Row(
                      children: [
                        Badge(
                          label: Text(cart.totalItems.toString()),
                          child: const Icon(
                            Icons.shopping_cart,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Корзина',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                '${cart.totalItems} товара • ${cart.totalPrice.toStringAsFixed(2)} ₽',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.arrow_drop_up_rounded,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _showCartBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return CartBottomSheet();
      },
    );
  }
}
