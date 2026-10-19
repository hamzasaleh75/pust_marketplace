import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_store/core/data/mock_data.dart';
import 'package:quick_store/core/shared/widgets/empty_widget.dart';
import 'package:quick_store/core/shared/widgets/search_widget.dart';
import 'package:quick_store/core/shared/widgets/network_image.dart';
import 'package:quick_store/features/home_screen/presentation/bloc/home_bloc.dart';

class SelectedProducts extends StatefulWidget {
  const SelectedProducts({super.key});

  @override
  State<SelectedProducts> createState() => _SelectedProductsState();
}

class _SelectedProductsState extends State<SelectedProducts> {
  Set<String>? filteredIds;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<HomeBloc>();

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final products = bloc.selectedProducts.where((product) {
          return filteredIds == null || filteredIds!.contains(product.id);
        }).toList();

        final totalCount = bloc.selectedProducts.fold<int>(
          0,
          (sum, product) => sum + product.count,
        );

        final totalPrice = bloc.selectedProducts.fold<double>(
          0,
          (sum, product) => sum + product.price * product.count,
        );

        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Selected Products ($totalCount)',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    TextButton(
                      onPressed: bloc.selectedProducts.isEmpty
                          ? null
                          : () {
                              showModalBottomSheet(
                                context: context,
                                builder: (sheetContext) {
                                  return Container(
                                    width: 320,
                                    child: Padding(
                                      padding: const EdgeInsets.all(24),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        
                                        children: [
                                          const Text(
                                            'Are you sure you want to clear?',
                                          ),
                                          const SizedBox(height: 16),
                                          ElevatedButton(
                                            onPressed: () {
                                              bloc.add(ClearCartEvent());
                                              setState(() {
                                                filteredIds = null;
                                              });
                                              Navigator.pop(sheetContext);
                                            },
                                            child: const Text('Clear'),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                      child: const Text('Clear'),
                    ),
                  ],
                ),
                const Divider(height: 30),

                CustomSearchWidget(
                  list: bloc.selectedProducts,
                  onSearch: (result) {
                    setState(() {
                      filteredIds = result.map((product) => product.id).toSet();
                    });
                  },
                ),

                const SizedBox(height: 10),

                if (products.isEmpty)
                  Expanded(
                    child: EmptyWidget(
                      onRefresh: () {},
                      title: 'No Selected Products',
                    ),
                  )
                else
                  Expanded(
                    child: ListView.separated(
                      itemCount: products.length,
                      separatorBuilder: (_, _) => const Divider(height: 20),
                      itemBuilder: (context, index) {
                        final product = products[index];

                        return Row(
                          children: [
                            SizedBox(
                              width: 80,
                              height: 80,
                              child: CustomNetworImage(
                                url: product.imageUrl,
                                imageWidth: 80,
                                imageHeight: 80,
                              ),
                            ),
                            const SizedBox(width: 12),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.title,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    '${product.price} JD',
                                    style: TextStyle(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 6),

                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          bloc.add(
                                            UpdateProductCountEvent(
                                              productId: product.id,
                                              change: -1,
                                            ),
                                          );
                                        },
                                        icon: const Icon(
                                          Icons.remove_circle_outline,
                                        ),
                                      ),
                                      Text(
                                        '${product.count}',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.titleMedium,
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          bloc.add(
                                            UpdateProductCountEvent(
                                              productId: product.id,
                                              change: 1,
                                            ),
                                          );
                                        },
                                        icon: const Icon(
                                          Icons.add_circle_outline,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),

                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        '${totalPrice.toStringAsFixed(2)} JD',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
