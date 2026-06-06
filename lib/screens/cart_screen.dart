import 'package:flutter/material.dart';
import '../helpers/cart_db_helper.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // request fresh rows from sqflite
  void _refreshCart() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    return FutureBuilder<List<Map<String, dynamic>>>(
      future: CartDBHelper.getCartItems(),
      builder: (context, snapshot) {
        final cartItems = snapshot.data ?? [];

        // price calculate of all items
        double overallTotal = 0.0;
        for (var item in cartItems) {
          double price = double.tryParse(item['price'].toString()) ?? 0.0;
          int qty = int.tryParse(item['quantity'].toString()) ?? 1;
          overallTotal += (price * qty);
        }

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Your Order Selection",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
                Text(
                  "Local SQFlite structured persistence engine",
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                ),
                const SizedBox(height: 20),

                if (cartItems.isEmpty)
                  const Expanded(
                    child: Center(
                      child: Text(
                        "Your cart is empty. Add food from the menu!",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  )
                else ...[
                  // scrollable column list displaying db items
                  Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        final item = cartItems[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: theme.colorScheme.primary
                                  .withValues(alpha: 0.1),
                              child: Text(
                                "${item['quantity']}x",
                                style: TextStyle(
                                  color: theme.colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            title: Text(
                              item['item_name'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              "Rs. ${(item['price'] * item['quantity']).toStringAsFixed(2)}",
                            ),
                            trailing: IconButton(
                              icon: const Icon(
                                Icons.delete_outline_rounded,
                                color: Colors.redAccent,
                              ),
                              onPressed: () async {
                                // Run delete parameter query on selected entry row id matching
                                await CartDBHelper.removeFromCart(item['id']);
                                _refreshCart(); // Re-trigger the local view update
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const Divider(),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Estimated Total:",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Rs. ${overallTotal.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colorScheme.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () async {
                        // clear the db
                        await CartDBHelper.clearCart();
                        _refreshCart();
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Order sent to canteen processing core successfully!",
                              ),
                              backgroundColor: Colors.green,
                            ),
                          );
                        }
                      },
                      child: const Text(
                        "Submit Order Confirmation",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
