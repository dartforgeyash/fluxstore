import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

class AppImage extends StatelessWidget {
  final String? url;
  final double? width;
  final double? height;
  final BoxFit fit;
  final double borderRadius;

  const AppImage({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    // Agar URL khali hai toh placeholder dikhao
    if (url == null || url!.isEmpty) {
      return _buildPlaceholder();
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: CachedNetworkImage(
        imageUrl: url!,
        width: width,
        height: height,
        fit: fit,
        // Jab image load ho rahi ho (Skeleton/Shimmer effect)
        placeholder: (context, url) => _buildShimmer(),
        // Jab image load fail ho jaye
        errorWidget: (context, url, error) => _buildPlaceholder(),
      ),
    );
  }

  // Sundar Skeleton effect
  Widget _buildShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: width ?? double.infinity,
        height: height ?? double.infinity,
        color: Colors.white,
      ),
    );
  }

  // Error ya Empty URL ke liye placeholder
  Widget _buildPlaceholder() {
    return Container(
      width: width,
      height: height,
      color: Colors.grey[200],
      child: const Icon(Icons.image_not_supported, color: Colors.grey),
    );
  }
}

// HOW TO USE

/* AppImage(
  url: "https://example.com/image.jpg",
  width: 100,
  height: 100,
  borderRadius: 10,
  fit: BoxFit.cover,
) */
