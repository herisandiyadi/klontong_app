import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entities/product_entity.dart';
import 'package:klontong_app/injection/injection.dart';
import '../../data/datasources/cart_local_datasource.dart';

class PaymentPage extends StatelessWidget {
  final List<ProductEntity> products;
  const PaymentPage({Key? key, required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final total = products.fold<int>(0, (sum, p) => sum + p.price);
    return Scaffold(
      appBar: AppBar(title: const Text('Payment')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Products:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final p = products[index];
                  return ListTile(
                    leading: Image.network(
                      p.image,
                      width: 48,
                      height: 48,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/img/placeholder_img.jpg',
                          width: 48,
                          height: 48,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                    title: Text(p.name),
                    subtitle: Text('Rp${p.price}'),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Total: Rp$total',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF03AC0E),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                onPressed: () async {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder:
                        (context) =>
                            const Center(child: CircularProgressIndicator()),
                  );
                  await Future.delayed(const Duration(seconds: 2));
                  Navigator.of(context).pop(); // close loading
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder:
                        (context) => Dialog(
                          backgroundColor: Colors.transparent,
                          child: Image.asset('assets/img/payment.jpg'),
                        ),
                  );
                  await Future.delayed(const Duration(seconds: 2));
                  // Delete selected products from cart
                  for (final p in products) {
                    await sl<CartLocalDataSource>().deleteCart(p.id);
                  }
                  if (context.mounted) {
                    Navigator.of(context).pop(); // close image
                    context.goNamed("/");
                  }
                },
                child: const Text(
                  'Pay Now',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
