import 'package:flutter/material.dart';

class CustomNetworImage extends StatelessWidget {
  const CustomNetworImage({
    super.key,
    required this.url,
    this.imageHeight = 100,  this.imageWidth=double.infinity,
  });
  final String url;
  final double imageHeight;
  final double imageWidth;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.network(
        url,
        height: imageHeight,
        fit: BoxFit.fitWidth,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: double.infinity,
            height: imageHeight,
            color: Theme.of(context).colorScheme.onPrimary,
            child: Icon(
              Icons.broken_image,
              color: Theme.of(context).colorScheme.error.withValues(alpha: .7),
              size: 50,
            ),
            
          );
          
        },
        width: imageWidth,
        
      ),
    );
  }
}
