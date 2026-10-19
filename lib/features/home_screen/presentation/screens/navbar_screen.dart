import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quick_store/core/constants/url_images.dart';
import 'package:quick_store/core/data/mock_data.dart';
import 'package:quick_store/core/shared/widgets/network_image.dart';
import 'package:quick_store/features/home_screen/presentation/bloc/home_bloc.dart';
import 'package:quick_store/features/home_screen/presentation/screens/home_screen.dart';
import 'package:quick_store/features/home_screen/presentation/screens/selected_products.dart';
import 'package:url_launcher/url_launcher.dart';

class NavbarScreen extends StatefulWidget {
  const NavbarScreen({super.key});

  @override
  State<NavbarScreen> createState() => _NavbarScreenState();
}

class _NavbarScreenState extends State<NavbarScreen>
    with TickerProviderStateMixin {
  int currentIndex = 0;
  List<MockProduct> products = MockData.products;
  late TabController tabController = TabController(length: 2, vsync: this);
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<HomeBloc>();
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Quiq Store',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      drawer: Drawer(
        width: MediaQuery.of(context).size.width * .6,
        child: Padding(
          padding: .only(top: 50, left: 10, right: 20, bottom: 40),
          child: Column(
            children: [
              Center(
                child: CustomNetworImage(
                  url: UrlImages.profileImage,
                  imageHeight: 100,
                  imageWidth: 100,
                ),
              ),
              Text('PSUT Student'),
              const Divider(color: Colors.black, thickness: 2, height: 20),
              Expanded(
                child: ListView(
                  padding: .zero,
                  children: [
                    ListTile(
                      contentPadding: .symmetric(horizontal: 5),
                      onTap: () {},
                      title: Text(
                        'Profile',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      trailing: Icon(Icons.person),
                    ),
                    ListTile(
                      contentPadding: .symmetric(horizontal: 5),
                      onTap: () => {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Container(
                              height: 200,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                              ),
                              child: Center(
                                child: Column(
                                  children: [
                                    Text(
                                      'Language',
                                      style: Theme.of(
                                        context,
                                      ).textTheme.titleLarge,
                                    ),
                                    RadioListTile(
                                      title: Text(
                                        'English',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.titleLarge,
                                      ),
                                      value: 'en',
                                      groupValue: 'en',
                                      onChanged: (value) {},
                                    ),
                                    RadioListTile(
                                      title: Text(
                                        'Arabic',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.titleLarge,
                                      ),
                                      value: 'ar',
                                      groupValue: 'en',
                                      onChanged: (value) {},
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      },
                      title: Text(
                        'Language',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      trailing: Icon(Icons.language),
                    ),
                    ListTile(
                      contentPadding: .symmetric(horizontal: 5),
                      enabled: false,
                      onTap: () {},
                      title: Text(
                        'Settings',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      trailing: Icon(Icons.settings),
                    ),

                    ListTile(
                      contentPadding: .symmetric(horizontal: 5),
                      onTap: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SelectedProducts(),
                          ),
                        ),
                      },
                      enabled: false,
                      title: Text(
                        'Cart',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      subtitle: Text('review your selected proudctus'),
                      trailing: Icon(Icons.keyboard_arrow_right_outlined),
                    ),
                    ListTile(
                      contentPadding: .symmetric(horizontal: 5),
                      onTap: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SelectedProducts(),
                          ),
                        ),
                      },
                      title: Text(
                        'About Us',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      subtitle: Text('learn more about PUST'),
                      trailing: Icon(Icons.info),
                    ),
                    ListTile(
                      contentPadding: .symmetric(horizontal: 5),
                      onTap: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SelectedProducts(),
                          ),
                        ),
                      },
                      title: Text(
                        'Help',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      subtitle: Text('find answers for FQs and more'),
                      trailing: Icon(Icons.help),
                    ),
                    ListTile(
                      contentPadding: .symmetric(horizontal: 5),
                      onTap: () => {launchUrl(Uri.parse('https://google.com'))},
                      title: Text(
                        'Rate US',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      trailing: Icon(Icons.star_border),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  context.go('/Login');
                },
                child: Row(
                  spacing: 10,
                  children: [
                    Icon(Icons.logout, size: 30, color: Colors.red),

                    Text(
                      'Logout',
                      style: TextStyle(color: Colors.red, fontSize: 22),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      body: currentIndex == 0
          ? HomeScreen()
          : SelectedProducts(),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
            if (index == 1) {
              products = products.where((pr) => pr.isFavorite).toList();
            } else {
              products = MockData.products;
            }
          });
        },
        selectedItemColor: Colors.deepOrange,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box),
            label: 'Proudcuts',
          ),
          BottomNavigationBarItem(
  icon: BlocBuilder<HomeBloc, HomeState>(
    builder: (context, state) {
      final bloc = context.read<HomeBloc>();

      final totalCount = bloc.selectedProducts.fold<int>(
        0,
        (sum, product) => sum + product.count,
      );

      return Badge(
        isLabelVisible: totalCount > 0,
        label: Text('$totalCount'),
        child: Icon(
          currentIndex == 1
              ? Icons.shopping_cart
              : Icons.shopping_cart_outlined,
        ),
      );
    },
  ),
  label: 'Cart',
),
        ],
      ),
      // floatingActionButton: floatingActionButtonWidget(context) ,
    );
  }
}
  //  Widget floatingActionButtonWidget(BuildContext context) {
  //   return Badge(
  //     isLabelVisible: selectedProducts.isNotEmpty,
  //     largeSize: 20,
  //     label: Text(
  //       selectedProducts.length.toString(),
  //       style: Theme.of(
  //         context,
  //       ).textTheme.titleSmall?.copyWith(color: AppColors.white),
  //     ),
  //     child: FloatingActionButton(
  //       onPressed: () {
  //         print(
  //           selectedProducts.map(
  //             (pr) => ('pr Name : ${pr.title} price ${pr.price}\n'),
  //           ),
  //         );
  //       },
  //       backgroundColor: Theme.of(context).colorScheme.primary,
  //       child: Icon(Icons.shopping_cart),
  //     ),
  //   );
  // }}