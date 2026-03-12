// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum ImageSource { asset, file, network }

class CommonImageView extends StatelessWidget {
  final String imagePath;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Color? color;
  final ImageSource source;
  final Widget? placeholder;

  // ✅ NEW: padding (default 0)
  final EdgeInsetsGeometry padding;

  const CommonImageView({
    super.key,
    required this.imagePath,
    required this.source,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.color,
    this.placeholder,
    this.padding = EdgeInsets.zero, // ✅ default 0
  });

  bool get _isSvg => imagePath.toLowerCase().endsWith('.svg');

  @override
  Widget build(BuildContext context) {
    Widget imageWidget;

    switch (source) {
      case ImageSource.asset:
        imageWidget = _isSvg
            ? SvgPicture.asset(
          imagePath,
          width: width,
          height: height,
          fit: fit,
          color: color,
          placeholderBuilder: (_) =>
          placeholder ??
              const Center(child: CircularProgressIndicator()),
        )
            : Image.asset(
          imagePath,
          width: width,
          height: height,
          fit: fit,
          color: color,
        );
        break;

      case ImageSource.file:
        imageWidget = Image.file(
          File(imagePath),
          width: width,
          height: height,
          fit: fit,
          color: color,
        );
        break;

      case ImageSource.network:
        imageWidget = _isSvg
            ? SvgPicture.network(
          imagePath,
          width: width,
          height: height,
          fit: fit,
          color: color,
          placeholderBuilder: (_) =>
          placeholder ??
              const Center(child: CircularProgressIndicator()),
        )
            : CachedNetworkImage(
          imageUrl: imagePath,
          width: width,
          height: height,
          fit: fit,
          color: color,
          placeholder: (_, _) =>
          placeholder ??
              const Center(child: CircularProgressIndicator()),
          errorWidget: (_, _, _) => const Icon(Icons.error),
        );
        break;
    }

    // ✅ Wrap with Padding
    return Padding(
      padding: padding,
      child: imageWidget,
    );
  }
}