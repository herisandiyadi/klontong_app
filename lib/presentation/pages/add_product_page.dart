import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/product_entity.dart';
import '../bloc/product_bloc.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({Key? key}) : super(key: key);

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _imageController = TextEditingController();
  final _descController = TextEditingController();
  final _weightController = TextEditingController();
  int? _selectedCategoryId;
  String? _selectedCategoryName;
  final List<Map<String, dynamic>> _categories = [
    {'id': 14, 'name': 'Cemilan'},
    {'id': 15, 'name': 'Minuman'},
    {'id': 16, 'name': 'Sembako'},
  ];
  final _skuController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _imageController.dispose();
    _descController.dispose();
    _weightController.dispose();
    // _categoryController.dispose();
    _skuController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      final product = ProductEntity(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        categoryId: _selectedCategoryId ?? 0,
        categoryName: _selectedCategoryName ?? '',
        sku: _skuController.text,
        name: _nameController.text,
        description: _descController.text,
        weight: int.tryParse(_weightController.text) ?? 0,
        width: 0,
        length: 0,
        height: 0,
        image: _imageController.text,
        price: int.tryParse(_priceController.text) ?? 0,
      );
      context.read<ProductBloc>().add(AddProductEvent(product));
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Product added!')));
      _formKey.currentState?.reset();
      _nameController.clear();
      _priceController.clear();
      _imageController.clear();
      _descController.clear();
      _weightController.clear();
      setState(() {
        _selectedCategoryId = null;
        _selectedCategoryName = null;
      });
      _skuController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Product')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Product Name'),
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _imageController,
                decoration: const InputDecoration(labelText: 'Image URL'),
              ),
              TextFormField(
                controller: _descController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
              TextFormField(
                controller: _weightController,
                decoration: const InputDecoration(labelText: 'Weight (gram)'),
                keyboardType: TextInputType.number,
              ),
              DropdownButtonFormField<int>(
                value: _selectedCategoryId,
                decoration: const InputDecoration(labelText: 'Category Name'),
                items:
                    _categories
                        .map(
                          (cat) => DropdownMenuItem<int>(
                            value: cat['id'],
                            child: Text(cat['name']),
                          ),
                        )
                        .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategoryId = value;
                    _selectedCategoryName =
                        _categories.firstWhere(
                          (cat) => cat['id'] == value,
                        )['name'];
                  });
                },
                validator: (v) => v == null ? 'Please select a category' : null,
              ),
              TextFormField(
                controller: _skuController,
                decoration: const InputDecoration(labelText: 'SKU'),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF03AC0E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: _submit,
                  child: const Text(
                    'Add Product',
                    style: TextStyle(color: Colors.white, fontSize: 24),
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
