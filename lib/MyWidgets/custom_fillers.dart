import 'package:flutter/material.dart';

handeledNetworkImage(String? url) {
  return Image.network(
    height: 90,
    width: 100,
    url ?? '',
    fit: BoxFit.fill,
    loadingBuilder: (context, child, loadingProgress) {
      if (loadingProgress == null) return child;
      return Center(
        child: CircularProgressIndicator(
          value: loadingProgress.expectedTotalBytes != null
              ? loadingProgress.cumulativeBytesLoaded /
              (loadingProgress.expectedTotalBytes ?? 1)
              : null,
        ),
      );
    },
    errorBuilder: (context, error, stackTrace) {
      return const Center(
        child: Icon(Icons.error, color: Colors.red),
      );
    },
  );
}