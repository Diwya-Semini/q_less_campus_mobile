import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/menu_provider.dart';

class FoodCard extends StatelessWidget {
  final Map<String, dynamic> item;
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

  @override
  Widget build(BuildContext context) {
    final double itemPrice = double.tryParse(item['price'].toString()) ?? 0.0;

    final menuProvider = Provider.of<MenuProvider>(context, listen: false);

    return Card(
      elevation: isDark ? 2 : 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      clipBehavior: Clip.antiAlias, // make sure content folow the card border
      color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. hybrid responsive img container
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: menuProvider.isOfflineMode
                    ? Image.asset(
                        item['local_image'] ?? 'assets/images/placeholder.png',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, StackTrace) =>
                            const Icon(
                              Icons.fastfood,
                              size: 50,
                              color: Colors.grey,
                            ),
                      )
                    : Image.network(
                        item['image_url'],
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, StackTrace) {
                          // defensive fallback if link fail to respond
                          return Image.asset(
                            item['local_image'] ??
                                'assets/images/placeholder.png',
                            fit: BoxFit.cover,
                            errorBuilder: (c, e, s) =>
                                const Icon(Icons.fastfood),
                          );
                        },
                      ),
              ),
            ),

            // 2. text cotainer with strict typo hierachy
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    item['item_name'] ?? 'Unknown Item',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),

                  const SizedBox(height: 2),
                  Text(
                    item['category'] ?? 'General',
                    style: const TextStyle(
                      fontSize: 11,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Rs. ${itemPrice.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          color: brandColor,
                        ),
                      ),
                      Icon(Icons.add_circle, color: brandColor, size: 22),
                    ],
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
