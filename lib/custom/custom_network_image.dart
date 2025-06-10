import 'package:flutter/material.dart';

class CustomNetworkImage extends StatelessWidget {
  final String? imageUrl; // Nullable to handle cases where URL might be null
  final double width;
  final double height;
  final double borderRadius;
  final double borderWidth;
  final Color borderColor;
  final String placeholderImage; // Asset image for placeholder
  final BoxShadow? boxShadow; // Optional shadow

  CustomNetworkImage({
    this.imageUrl,
    required this.width,
    required this.height,
    this.borderRadius = 0.0,
    this.borderWidth = 0.0,
    this.borderColor = Colors.transparent,
    this.placeholderImage =
        'assets/icons/placeholder.png', // Default placeholder
    this.boxShadow, // Optional shadow
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        border: borderWidth > 0
            ? Border.all(color: borderColor, width: borderWidth)
            : null,
        boxShadow: boxShadow != null ? [boxShadow!] : null,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child:
            imageUrl != null && Uri.tryParse(imageUrl!)?.hasAbsolutePath == true
                ? Image.network(
                    imageUrl!,
                    width: width,
                    height: height,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      } else {
                        return Center(
                            child: Image.asset(
                          placeholderImage,
                          width: width,
                          height: height,
                          fit: BoxFit.cover,
                        ));
                      }
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        placeholderImage,
                        width: width,
                        height: height,
                        fit: BoxFit.cover,
                      );
                    },
                  )
                : Image.asset(
                    placeholderImage,
                    width: width,
                    height: height,
                    fit: BoxFit.cover,
                  ),
      ),
    );
  }
}
