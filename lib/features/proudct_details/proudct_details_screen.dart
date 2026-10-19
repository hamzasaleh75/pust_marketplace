import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quick_store/core/data/mock_data.dart';
import 'package:quick_store/core/shared/widgets/network_image.dart';
import 'package:quick_store/core/theme/app_colors.dart';
import 'package:quick_store/features/home_screen/presentation/bloc/home_bloc.dart';

class ProudctDetailsScreen extends StatefulWidget {
  final MockProduct product;
  final bool showAdd;
  const ProudctDetailsScreen({
    super.key,
    required this.product,
    this.showAdd = false,
  });

  @override
  State<ProudctDetailsScreen> createState() => _ProudctDetailsScreenState();
}

class _ProudctDetailsScreenState extends State<ProudctDetailsScreen> {
  final TextEditingController _counterController = TextEditingController(
    text: '1',
  );
  double? totalPrice;
  int quantity = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _counterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<HomeBloc>();
    return Scaffold(
      appBar: AppBar(title: Text('Proudct Details')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          spacing: 15,
          children: [
            heroImage(context),

            Text(
              widget.product.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),

            SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 5,
              children: [
                Icon(Icons.star, color: AppColors.rating),
                Text(
                  '${widget.product.rating} / 5',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  '(${widget.product.reviewCount})',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                Spacer(),
                Column(
                  spacing: 3,
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '\$ ${widget.product.oldPrice} JD ',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.lineThrough,
                        decorationThickness: 2,
                        decorationColor: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                    Text(
                      '\$ ${widget.product.price}JD',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            // SizedBox(height: 20),
            // Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.tertiary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    widget.product.discountTag,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            if (widget.showAdd)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        if (quantity > 1) {
                          setState(() {
                            quantity--;
                            totalPrice = widget.product.price * quantity;
                            _counterController.text = '$quantity';
                          });
                        }
                      },
                      icon: const Icon(Icons.remove_circle_outline),
                    ),

                    Expanded(
                      child: TextField(
                        controller: _counterController,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Quantity',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          final parsedQuantity = int.tryParse(value);

                          setState(() {
                            if (parsedQuantity != null && parsedQuantity > 0) {
                              quantity = parsedQuantity;
                              totalPrice = widget.product.price * quantity;
                            } else if (value.isEmpty) {
                              totalPrice = 0;
                            }
                          });
                        },
                      ),
                    ),

                    IconButton(
                      onPressed: () {
                        setState(() {
                          quantity++;
                          totalPrice = widget.product.price * quantity;
                          _counterController.text = '$quantity';
                        });
                      },
                      icon: const Icon(Icons.add_circle_outline),
                    ),

                    const SizedBox(width: 8),

                    Expanded(
                      child: Text(
                        'Total:\n${(totalPrice ?? widget.product.price).toStringAsFixed(2)} JD',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),

            if (widget.showAdd)
              ElevatedButton.icon(
                onPressed: () {
                  final selectedQuantity = int.tryParse( 
                    _counterController.text,
                  );

                  if (selectedQuantity == null || selectedQuantity < 1) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please enter a valid quantity'),
                      ),
                    );
                    return;
                  }

                  bloc.add(
                    AddProductCartEvent(
                      product: widget.product,
                      quantity: selectedQuantity,
                    ),
                  );

                  context.go('/');
                },

                label: Text(
                  'Add',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                icon: Icon(Icons.shopping_cart_outlined, size: 20),
                style: ButtonStyle(
                  padding: WidgetStatePropertyAll(
                    EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                  backgroundColor: WidgetStatePropertyAll(
                    Theme.of(context).colorScheme.primary,
                  ),
                  foregroundColor: WidgetStatePropertyAll(AppColors.white),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(5),
                    ),
                  ),
                ),
              ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Hero heroImage(BuildContext context) {
    return Hero(
      tag: widget.product.id,

      child: Stack(
        children: [
          CustomNetworImage(url: widget.product.imageUrl, imageHeight: 225),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: IconButton(
              onPressed: () {
                setState(() {
                  widget.product.isFavorite = !widget.product.isFavorite;
                });
              },
              padding: EdgeInsets.all(10),
              color: AppColors.red,
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(
                  AppColors.red.withValues(alpha: .3),
                ),
              ),
              icon: Icon(
                widget.product.isFavorite
                    ? Icons.favorite
                    : Icons.favorite_outline,
                color: Theme.of(context).colorScheme.tertiary,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
