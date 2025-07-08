import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'product_detail_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../bloc/product_bloc.dart';
import '../../domain/entities/product_entity.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ScrollController _scrollController;
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductBloc>().add(FetchProductsEvent());
    });
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      final bloc = context.read<ProductBloc>();
      final state = bloc.state;
      if (state is ProductLoaded && state.hasMore && !state.isLoadingMore) {
        bloc.add(FetchProductsEvent(isNextPage: true));
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product List')),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductLoaded) {
            List<ProductEntity> filtered = state.products;
            if (searchQuery.isNotEmpty) {
              filtered =
                  state.products
                      .where(
                        (p) => p.name.toLowerCase().contains(
                          searchQuery.toLowerCase(),
                        ),
                      )
                      .toList();
            }
            if (filtered.isEmpty) {
              return Column(
                children: [
                  _buildSearchBar(),
                  const Expanded(
                    child: Center(child: Text('No products found.')),
                  ),
                ],
              );
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Column(
                children: [
                  _buildSearchBar(),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        context.read<ProductBloc>().add(FetchProductsEvent());
                      },
                      child: Column(
                        children: [
                          Expanded(
                            child: GridView.builder(
                              controller: _scrollController,
                              itemCount: filtered.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 12,
                                    crossAxisSpacing: 12,
                                    childAspectRatio: 0.68,
                                  ),
                              itemBuilder: (context, index) {
                                final product = filtered[index];
                                return GestureDetector(
                                  onTap: () {
                                    context.go(
                                      '/home/product-detail',
                                      extra: product,
                                    );
                                  },
                                  child: Card(
                                    elevation: 2,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              const BorderRadius.vertical(
                                                top: Radius.circular(12),
                                              ),
                                          child: CachedNetworkImage(
                                            imageUrl: product.image,
                                            height: 120,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                            placeholder:
                                                (context, url) => Image.asset(
                                                  'assets/img/placeholder_img.jpg',
                                                  height: 120,
                                                  width: double.infinity,
                                                  fit: BoxFit.cover,
                                                ),
                                            errorWidget:
                                                (
                                                  context,
                                                  url,
                                                  error,
                                                ) => Image.asset(
                                                  'assets/img/placeholder_img.jpg',
                                                  height: 120,
                                                  width: double.infinity,
                                                  fit: BoxFit.cover,
                                                ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            product.name,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0,
                                          ),
                                          child: Text(
                                            'Rp${product.price}',
                                            style: const TextStyle(
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ),
                                        const Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0,
                                            vertical: 6,
                                          ),
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons.shopping_cart_outlined,
                                                size: 16,
                                                color: Colors.grey,
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                '${product.weight}g',
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          if (state.isLoadingMore && searchQuery.isEmpty)
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              child: Center(child: CircularProgressIndicator()),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (state is ProductError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search product...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 0,
            horizontal: 12,
          ),
        ),
        onChanged: (value) {
          setState(() {
            searchQuery = value;
          });
        },
      ),
    );
  }
}
