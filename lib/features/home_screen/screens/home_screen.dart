import 'package:flutter/material.dart';
import 'package:quick_store/core/data/mock_data.dart';
import 'package:quick_store/core/shared/widgets/search_widget.dart';
import 'package:quick_store/features/home_screen/widgets/products_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.selectedproducts});
  final List<MockProduct> selectedproducts;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  List<MockProduct> products = List.from(MockData.products);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            spacing: 20,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // lectureDetails(context),
              Text(
                "Featured Products",
                overflow: TextOverflow.ellipsis,
                maxLines: 4,
                style: Theme.of(context).textTheme.titleLarge,
              ),

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text(
              //       'numbers of selected prouducts ${selectedproducts.length.toString()}',
              //     ),
              //     GestureDetector(
              //       onTap: () {
              //         // Navigator.of(context).pop();
              //         setState(() {
              //           selectedproducts.clear();
              //         });
              //       },
              //       child: Text('Clear'),
              //     ),
              //   ],
              // ),

              // FiltersWidgets(
              //   onSearch: (value) {
              //     setState(() {
              //       final backUp = products;
              //       products = products
              //           .where(
              //             (product) => product.title.toLowerCase().contains(
              //               value.toLowerCase(),
              //             ),
              //           )
              //           .toList();
              //       value == "" ? products = backUp : null;
              //     });
              //   },
              //   onCheckBox: (value) {
              //     setState(() {
              //       if (value == true) {
              //         products.sort((a, b) => a.title.compareTo(b.title));
              //       } else {
              //         products.sort((a, b) => b.title.compareTo(a.title));
              //       }
              //     });
              //   },
              //   onRadioSelected: (value) {
              //     setState(() {
              //       if (value == Options.AtoZ) {
              //         products.sort((a, b) => a.title.compareTo(b.title));
              //       } else if (value == Options.ZtoA) {
              //         products.sort((a, b) => b.title.compareTo(a.title));
              //       } else if (value == Options.none) {
              //         value = MockData.products;
              //       }
              //     });
              //   },
              //   onSwitchSelected: (value) {
              //     setState(() {
              //       if (value == true) {
              //         products = products
              //             .where((product) => product.price < 100)
              //             .toList();
              //       } else {
              //         products = MockData.products;
              //       }
              //     });
              //   },
              //   onCategoryChanged: (value) {
              //     setState(() {
              //       value == "All"
              //           ? products = MockData.products
              //           : products = MockData.products
              //                 .where((product) => product.category == value)
              //                 .toList();
              //     });
              //   },

              // ),

              // SizedBox(height: 35,width: 300,
              //   child: TabBarView(
              //     controller: TabController(length: 2, vsync: this),
              //     children: [
              //       Text(
              //         'Prouducts',
              //         style: Theme.of(context).textTheme.titleLarge,
              //       ),
              //       Text('Carts', style: Theme.of(context).textTheme.titleLarge),
              //     ],
              //   ),
              // ),
              // (child: TabBar(tabs: [Tab(text: 'All',),Tab(text: 'hy',)])),
              CustomSearchWidget(
                list: products,
                onSearch: (value) {
                  setState(() {
                    if (value.isEmpty) {
                      products = MockData.products;
                    } else {
                      products = value;
                    }
                  });
                },
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ProductsGridView(
                    products: products,
                    selectedproducts: widget.selectedproducts,
                    refresh: () {
                      setState(() {});
                    },
                    showAdd: true,
                    showBadge: true,
                    showFavorite: true,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //   Widget lectureDetails(BuildContext context) {
  //     final String content =
  //         ".Container .Row .Column .Stack \n"
  //         ".SizedBox .Expanded .Flexible .Spacer";
  //     return InkWell(
  //       onLongPress: () {
  //         Clipboard.setData(ClipboardData(text: content));

  //         // ScaffoldMessenger.of(context).showSnackBar(
  //         //   SnackBar(
  //         //     content: Text('Copied successfully : \n$content'),
  //         //     duration: Duration(seconds: 20),
  //         //     backgroundColor: Theme.of(context).colorScheme.primary,
  //         //   ),
  //         // );
  //         DelightToastBar(
  //           builder: (context) => ToastCard(
  //             leading: Icon(Icons.flutter_dash, size: 28),
  //             title: Text(
  //               'Successfuly Copied!',
  //               style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
  //             ),
  //             subtitle: Text(content),
  //           ),
  //         ).show(context);
  //       },
  //       child: Container(
  //         padding: EdgeInsets.all(15),
  //         decoration: BoxDecoration(
  //           border: Border.all(
  //             color: Theme.of(context).colorScheme.primary,
  //             width: 1,
  //           ),
  //           borderRadius: BorderRadius.circular(10),
  //           color: Theme.of(context).colorScheme.primary.withValues(alpha: .3),
  //         ),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           spacing: 5,
  //           children: [

  //             Text(content, style: Theme.of(context).textTheme.titleMedium),
  //           ],
  //         ),
  //       ),
  //     );
  //   }
  // }
}
