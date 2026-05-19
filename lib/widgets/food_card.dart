import 'package:flutter/material.dart';
import '../models/product.dart';

class FoodCard extends StatelessWidget {
  final Product item;
  final bool isDark;
  final Color brandColor;
  final VoidCallback onTap;

  const FoodCard({
    super.key,
    required this.item,
    required this.isDark,
    required this.brandColor,
    required this.onTap,
  });

  String _getValidImageUrl(String? url) {
    // 1. If it's null or completely empty, use the fallback salad
    if (url == null || url.trim().isEmpty) {
      return 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80';
    }

    // 2. If Laravel sent a full URL, convert localhost for the Android Emulator
    if (url.startsWith('http')) {
      return url
          .replaceAll('127.0.0.1', '10.0.2.2')
          .replaceAll('localhost', '10.0.2.2');
    }
    // 3. If Laravel sent a relative path (e.g., 'storage/products/image.jpg')
    // We attach the emulator's local IP and port to the front of it!
    else {
      // Remove leading slash if it exists to prevent double slashes
      final cleanPath = url.startsWith('/') ? url.substring(1) : url;

      // If your images are in Laravel's storage folder, we format it perfectly
      if (!cleanPath.startsWith('storage/')) {
        return 'http://10.0.2.2:8000/storage/$cleanPath';
      } else {
        return 'http://10.0.2.2:8000/$cleanPath';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isDark
              ? Colors.white.withValues(alpha: 0.05)
              : const Color(0xFFF0F0F0),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                child: Image.network(
                  _getValidImageUrl(item.imageUrl),
                  width: double.infinity,
                  fit: BoxFit.cover,
                  // 3. If the image fails to load for ANY reason, show an icon instead of blank space
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: isDark ? Colors.black26 : Colors.grey[200],
                      child: const Center(
                        child: Icon(
                          Icons.broken_image_rounded,
                          color: Colors.grey,
                          size: 40,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.itemName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "Rs. ${item.price.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: brandColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
