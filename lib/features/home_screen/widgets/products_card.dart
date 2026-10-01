import 'package:flutter/material.dart';
import 'package:quick_store/core/data/mock_data.dart';
import 'package:quick_store/core/shared/widgets/empty_widget.dart';
import 'package:quick_store/core/shared/widgets/products_card.dart';

// ignore: must_be_immutable
class ProductsGridView extends StatefulWidget {
  ProductsGridView({
    super.key,
    required this.products,
    this.selectedproducts = const [],
    required this.refresh,
    this.showAdd = false,
    this.showBadge = false,
    this.showFavorite = false,
  });
  final List<MockProduct> products;
  List<MockProduct> selectedproducts;
  final Function refresh;
  final bool showBadge;
  final bool showAdd;
  final bool showFavorite;

  @override
  State<ProductsGridView> createState() => _ProductsGridViewState();
}

class _ProductsGridViewState extends State<ProductsGridView> {
  List<MockProduct> get product => widget.products;
  @override
  Widget build(BuildContext context) {
    // final screenWidth = MediaQuery.sizeOf(context).width;
    // final screenHeight = MediaQuery.sizeOf(context).height;
    // final textSize = screenWidth * .03;
    // final isSized = screenHeight > 300;

    return widget.products.isEmpty
        ? EmptyWidget(onRefresh: () {}, title: 'No Products Found')
        : RefreshIndicator(
            onRefresh: () async {
              await widget.refresh();
              setState(() {});
            },
            child: GridView.extent(
              maxCrossAxisExtent: 250,
              // crossAxisCount: 3,
              mainAxisExtent: 300,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children: [
                ...widget.products.map(
                  (pr) => ProductsCard(
                    product: pr,
                    selectedproducts: widget.selectedproducts,
                    refresh: widget.refresh,
                    showAdd: widget.showAdd,
                    showBadge: widget.showBadge,
                    showFavorite: widget.showFavorite,
                  ),
                ),
              ],
            ),
          );
  }
}
