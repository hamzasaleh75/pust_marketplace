import 'package:flutter/material.dart';
import 'package:quick_store/core/constants/url_images.dart';
import 'package:quick_store/core/shared/widgets/network_image.dart';
import 'package:quick_store/core/theme/app_colors.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    super.key,
    required this.onRefresh,
    this.title = 'No Data Found',
    this.icon = Icons.broken_image_outlined,
    this.iconColor = AppColors.orange,
    this.iconSize = 50,
    this.showImageEmpty = true,
  });
  final Function onRefresh;
  final String title;
  final IconData? icon;
  final double? iconSize;
  final Color? iconColor;
  final bool showImageEmpty;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await onRefresh();
      },
      child: ListView(
        children: [
          if (!showImageEmpty)
            SizedBox(
              height: 50,
              width: double.infinity,
              child: Icon(icon, color: iconColor, size: iconSize),
            )
          else
            CustomNetworImage(imageHeight: 265, url: UrlImages.notFoundImage),
          Center(
            child: Text(title, style: Theme.of(context).textTheme.titleLarge),
          ),
        ],
      ),
    );
  }
}
