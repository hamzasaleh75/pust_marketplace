// import 'package:delightful_toast/delight_toast.dart';
// import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// import 'package:quick_store/core/theme/app_colors.dart';
// import 'package:quick_store/core/theme/app_colors.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 5,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            Icons.storefront,
            color: Theme.of(context).colorScheme.onSurface,
            size: 35,
          ),
        ),
        Expanded(
          child: Column(
            spacing: 5,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Quiq Store", style: Theme.of(context).textTheme.titleLarge),
              Text(
                "Lecture 7 fundemental layouts",
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontSize: 15),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          ),
        ),

        // Spacer(),
        IconButton(
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(
              Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
            ),
          ),
          onPressed: () {
            context.go('/Login');

            // DelightToastBar(
            //   autoDismiss: true,
            //   snackbarDuration: Duration(seconds: 2),
            //   builder: (context) => ToastCard(
            //     leading: Icon(Icons.flutter_dash, size: 28),
            //     title: Text('empty notifications'),
            //   ),
            // ).show(context);
          },
          icon: Badge(
            isLabelVisible: false,
            // offset: Offset(10, -10),
            // label: Text('5'),
            child: Icon(Icons.logout),
          ),
          color: Theme.of(context).colorScheme.primary,
        ),
      ],
    );
  }
}
