import 'package:flutter/material.dart';
import 'package:test_meat_gastronom/features/models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final bool isAdded;
  final VoidCallback onAddPressed;

  const ProductCard({
    super.key,
    required this.product,
    required this.isAdded,
    required this.onAddPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                product.imageUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Icon(Icons.image, size: 80),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: Theme.of(context).textTheme.titleMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${product.price.toStringAsFixed(2)} ₽',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Theme.of(context).primaryColor)
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            ElevatedButton(
              onPressed: onAddPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    isAdded ? Colors.green : Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(isAdded ? 'Добавлено' : 'Добавить'),
            ),
          ],
        ),
      ),
    );
  }
}