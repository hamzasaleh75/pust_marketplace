import 'package:flutter/material.dart';
import 'package:quick_store/core/data/mock_data.dart';
import 'package:quick_store/core/shared/widgets/empty_widget.dart';
import 'package:quick_store/core/shared/widgets/search_widget.dart';
import 'package:quick_store/features/home_screen/widgets/products_card.dart';

class SelectedProducts extends StatefulWidget {
  const SelectedProducts({super.key, required this.selectedProducts});
  final List<MockProduct> selectedProducts;

  @override
  State<SelectedProducts> createState() => _SelectedProductsState();
}

class _SelectedProductsState extends State<SelectedProducts> {
  late List<MockProduct> filteredProduct;

  @override
  void initState() {
    filteredProduct = widget.selectedProducts;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                  'Selected Products',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                TextButton(
                  child: Text('Clear'),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => Padding(
                        padding: .symmetric(vertical: 30, horizontal: 20),
                        child: SizedBox(
                          height: 100,
                          child: Center(
                            child: Column(
                              children: [
                                Text('Are you sure you want to clear?'),
                                Spacer(),

                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      widget.selectedProducts.clear();
                                    });
                                    Navigator.pop(context);
                                  },
                                  style: ButtonStyle(
                                    backgroundColor: WidgetStatePropertyAll(
                                      Theme.of(context).colorScheme.primary,
                                    ),
                                    foregroundColor: WidgetStatePropertyAll(
                                      Theme.of(context).colorScheme.onPrimary,
                                    ),
                                  ),
                                  child: Text('Clear'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            Divider(height: 30),
            CustomSearchWidget(
              list: widget.selectedProducts,
              onSearch: (result) {
                filteredProduct = result;

                setState(() {});
              },
            ),
            SizedBox(height: 10),
            if (filteredProduct.isEmpty)
              Expanded(
                child: EmptyWidget(
                  onRefresh: () {},
                  title: 'No Selected Products',
                ),
              )
            else
              Expanded(
                child: ProductsGridView(
                  products: filteredProduct,
                  refresh: () {},
                ),
              ),
          ],
        ),
      ),
    );
  }
}
