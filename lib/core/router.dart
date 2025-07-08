import 'package:go_router/go_router.dart';
import '../presentation/pages/splash_screen.dart';
import '../presentation/pages/homepage.dart';
import '../presentation/pages/product_detail_page.dart';
import '../presentation/pages/payment_page.dart';
import '../../domain/entities/product_entity.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
      routes: [
        GoRoute(
          path: 'home',
          builder: (context, state) => Homepage(selectedIndex: 0),
          routes: [
            GoRoute(
              path: 'product-detail',
              builder: (context, state) {
                final product = state.extra as ProductEntity;
                return ProductDetailPage(product: product);
              },
            ),
            GoRoute(
              path: 'payment',
              builder: (context, state) {
                final products = state.extra as List<dynamic>;
                return PaymentPage(products: products.cast());
              },
            ),
          ],
        ),
      ],
    ),
  ],
);
