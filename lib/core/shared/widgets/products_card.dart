import 'package:flutter/material.dart';
import 'package:quick_store/core/data/mock_data.dart';
import 'package:quick_store/core/shared/widgets/network_image.dart';
import 'package:quick_store/core/theme/app_colors.dart';
import 'package:quick_store/features/proudct_details/proudct_details_screen.dart';

class ProductsCard extends StatefulWidget {
  const ProductsCard({
    super.key,
    required this.product,
    required this.refresh,
    required this.selectedproducts,
    this.showBadge = false,
    this.showAdd = false,
    this.showFavorite = false,
  });
  final MockProduct product;
  final Function refresh;
  final List<MockProduct> selectedproducts;
  final bool showBadge;
  final bool showAdd;
  final bool showFavorite;

  @override
  State<ProductsCard> createState() => _ProductsCardState();
}

class _ProductsCardState extends State<ProductsCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        ProudctCustamiz? proudctCustamiz = await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProudctDetailsScreen(
              product: widget.product,
              showAdd: widget.showAdd,
              refresh: () {
                setState(() {});
                widget.refresh();
              },
              selectedproducts: widget.selectedproducts,
            ),
          ),
        );

        for (int i = 0; i < (proudctCustamiz?.count ?? 0); i++) {
          widget.selectedproducts.add(widget.product);
        }
      },
      child: Badge(
        offset: Offset(0, 5),
        alignment: Alignment.topLeft,
        backgroundColor: Theme.of(context).colorScheme.primary,
        label: Icon(Icons.check, color: AppColors.white),
        isLabelVisible:
            widget.showBadge &&
            widget.selectedproducts.contains(widget.product),
        padding: EdgeInsets.all(1),
        child: Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).colorScheme.primary),
            borderRadius: BorderRadius.circular(20),
            color: Theme.of(context).colorScheme.primary.withValues(alpha: .15),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 5,
            children: [
              Hero(
                tag:
                    '${widget.product.id}_${widget.selectedproducts.indexOf(widget.product)}',

                child: Stack(
                  children: [
                    CustomNetworImage(url: widget.product.imageUrl),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.tertiary,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              widget.product.discountTag,
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(
                                    fontSize: 12,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onPrimary,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                          if (widget.showFavorite)
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  widget.product.isFavorite =
                                      !widget.product.isFavorite;
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
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Text(
                widget.product.category,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Text(
                widget.product.title,
                style: Theme.of(context).textTheme.titleSmall,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
              // Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 5,
                children: [
                  Icon(Icons.star, color: AppColors.rating),
                  Text(
                    '${widget.product.rating} / 5',
                    // maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Text(
                    '(${widget.product.reviewCount})',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      spacing: 3,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '\$ ${widget.product.oldPrice} JD}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.titleSmall
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurfaceVariant,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.lineThrough,
                                decorationThickness: 2,
                                decorationColor: Theme.of(
                                  context,
                                ).colorScheme.tertiary,
                              ),
                        ),
                        Text(
                          '\$ ${widget.product.price}JD',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.titleSmall
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                  ),
                  if (widget.showAdd)
                    ElevatedButton.icon(
                      onPressed: () {
                        // print('Add ${product.title}');
                        widget.selectedproducts.add(widget.product);
                        // print(
                        //   'The number of selected products : ${widget.selectedproducts.length}',
                        // );
                        // print(
                        //   widget.selectedproducts
                        //       .map((sp) => sp.title)
                        //       .toList()
                        //       .join('----\n'),
                        // );
                        widget.refresh();
                      },

                      label: Text(
                        'Add',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      icon: Icon(Icons.shopping_cart_outlined, size: 20),
                      style: ButtonStyle(
                        padding: WidgetStatePropertyAll(EdgeInsets.all(7)),
                        backgroundColor: WidgetStatePropertyAll(
                          Theme.of(context).colorScheme.primary,
                        ),
                        foregroundColor: WidgetStatePropertyAll(
                          AppColors.white,
                        ),
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(5),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
