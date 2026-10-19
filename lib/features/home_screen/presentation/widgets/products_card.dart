import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_store/core/data/mock_data.dart';
import 'package:quick_store/core/shared/widgets/empty_widget.dart';
import 'package:quick_store/core/shared/widgets/products_card.dart';
import 'package:quick_store/features/home_screen/presentation/bloc/home_bloc.dart';

class ProductsGridView extends StatefulWidget {
  const ProductsGridView({
    super.key,
    required this.products,
    required this.refresh,
    this.showAdd = false,
    this.showBadge = false,
    this.showFavorite = false,
  });

  final List<MockProduct> products;
  final Function refresh;
  final bool showBadge;
  final bool showAdd;
  final bool showFavorite;

  @override
  State<ProductsGridView> createState() => _ProductsGridViewState();
}

class _ProductsGridViewState extends State<ProductsGridView> {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<HomeBloc>();

    return widget.products.isEmpty
        ? EmptyWidget(onRefresh: () {}, title: 'No Products Found')
        : RefreshIndicator(
            onRefresh: () async {
              await widget.refresh();
              setState(() {});
            },
            child: GridView.extent(
              maxCrossAxisExtent: 250,
              mainAxisExtent: 300,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children: [
                ...widget.products.map(
                  (pr) => ProductsCard(
                    product: pr,
                    selectedproducts: bloc.selectedProducts,
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