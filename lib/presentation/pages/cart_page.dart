import 'package:flutter/material.dart';
import '../../data/datasources/cart_local_datasource.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entities/product_entity.dart';
import 'package:klontong_app/injection/injection.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<ProductEntity> _cart = [];
  bool _loading = true;
  Set<String> _selectedIds = {};

  @override
  void initState() {
    super.initState();
    _fetchCart();
  }

  Future<void> _fetchCart() async {
    setState(() => _loading = true);
    final data = await sl<CartLocalDataSource>().getCartList();
    setState(() {
      _cart = data;
      _selectedIds = data.map((e) => e.id).toSet(); // default: all selected
      _loading = false;
    });
  }

  void _toggleSelectAll(bool? value) {
    setState(() {
      if (value == true) {
        _selectedIds = _cart.map((e) => e.id).toSet();
      } else {
        _selectedIds.clear();
      }
    });
  }

  void _toggleSelect(String id, bool? value) {
    setState(() {
      if (value == true) {
        _selectedIds.add(id);
      } else {
        _selectedIds.remove(id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final allSelected = _cart.isNotEmpty && _selectedIds.length == _cart.length;
    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body:
          _loading
              ? const Center(child: CircularProgressIndicator())
              : RefreshIndicator(
                onRefresh: _fetchCart,
                child:
                    _cart.isEmpty
                        ? const Center(child: Text('Cart is empty'))
                        : ListView.builder(
                          itemCount: _cart.length,
                          itemBuilder: (context, index) {
                            final product = _cart[index];
                            final selected = _selectedIds.contains(product.id);
                            return Card(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              child: ListTile(
                                leading: Checkbox(
                                  value: selected,
                                  onChanged:
                                      (v) => _toggleSelect(product.id, v),
                                ),
                                title: Text(product.name),
                                subtitle: Text('Rp${product.price}'),
                                trailing: Image.network(
                                  product.image,
                                  width: 56,
                                  height: 56,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset(
                                      'assets/img/placeholder_img.jpg',
                                      width: 56,
                                      height: 56,
                                      fit: BoxFit.cover,
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                        ),
              ),
      bottomNavigationBar:
          _cart.isEmpty
              ? null
              : SafeArea(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: BorderSide(color: Colors.grey.shade200, width: 1),
                    ),
                  ),
                  child: Row(
                    children: [
                      Checkbox(value: allSelected, onChanged: _toggleSelectAll),
                      const Text('Select All'),
                      const Spacer(),
                      Expanded(
                        child: SizedBox(
                          height: 44,
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
                            onPressed:
                                _selectedIds.isEmpty
                                    ? null
                                    : () {
                                      final selectedProducts =
                                          _cart
                                              .where(
                                                (p) =>
                                                    _selectedIds.contains(p.id),
                                              )
                                              .toList();
                                      context.go(
                                        '/home/payment',
                                        extra: selectedProducts,
                                      );
                                    },
                            child: const Text(
                              'Buy',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
    );
  }
}
