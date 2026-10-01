import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quick_store/core/data/mock_data.dart';
import 'package:quick_store/core/shared/widgets/network_image.dart';
import 'package:quick_store/core/theme/app_colors.dart';

class ProudctDetailsScreen extends StatefulWidget {
  final MockProduct product;
  final void Function() refresh;
  final bool showAdd;
  final List selectedproducts;
  const ProudctDetailsScreen({
    super.key,
    required this.product,
    required this.refresh,
    required this.selectedproducts,
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
  ProudctCustamiz? proudctCustamiz;

  @override
  void initState() {
    proudctCustamiz = ProudctCustamiz(
      id: widget.product.id,
      prColor: Colors.white,
      count: 1,
    );
    super.initState();
    totalPrice = widget.product.price;
  }

  @override
  void dispose() {
    _counterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  spacing: 30,
                  children: [
                    Expanded(
                      child: TextField(
                        onTapOutside: (event) =>
                            FocusScope.of(context).unfocus(),
                        decoration: InputDecoration(
                          label: Text('Number of Proudcts'),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        controller: _counterController,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          if (value.isEmpty) {
                            proudctCustamiz?.count = 1;
                            totalPrice = widget.product.price * 1;
                          } else {
                            proudctCustamiz?.count = int.parse(value);

                            totalPrice =
                                widget.product.price * int.parse(value);
                          }
                          setState(() {});
                        },
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Toatal price is :\n  $totalPrice JD',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            if (widget.showAdd)
              ElevatedButton.icon(
                onPressed: () {
                  // Navigator.of(context).pop(proudctCustamiz);
                  context.go('/', extra: proudctCustamiz);

                  widget.refresh();
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
          CustomNetworImage(url: widget.product.imageUrl,imageHeight: 225,),
          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: IconButton(
              onPressed: () {
                setState(() {
                  widget.product.isFavorite = !widget.product.isFavorite;
                });
                widget.refresh();
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

class ProudctCustamiz {
  String? id;
  Color? prColor;
  int? count;

  ProudctCustamiz({
    required this.id,
    required this.prColor,
    required this.count,
  });
}
