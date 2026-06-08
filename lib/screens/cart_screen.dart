import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:q_less_campus/providers/cart_provider.dart';
import 'package:q_less_campus/providers/order_provider.dart';
import 'package:q_less_campus/widgets/custom_header.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    final cartProvider = Provider.of<CartProvider>(context, listen: true);
    final orderProvider = Provider.of<OrderProvider>(context, listen: true);
    final cartItems = cartProvider.cartItems;

    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xFF121212)
          : const Color(0xFFFAFAFA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomHeader(screenTitle: "Your Cart"),
              const SizedBox(height: 20),
              // if the cart is empty
              Expanded(
                child: cartItems.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primary.withValues(
                                  alpha: 0.05,
                                ),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.shopping_basket_outlined,
                                size: 64,
                                color: theme.colorScheme.primary.withValues(
                                  alpha: 0.6,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              "Your basket is empty",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Add some delicious items from the campus menu!",
                              style: TextStyle(
                                color: Colors.grey.shade500,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      )
                    // else show the items in cart
                    : Column(
                        children: [
                          // Scrolling food item list
                          Expanded(
                            child: ListView.builder(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              physics: const BouncingScrollPhysics(),
                              itemCount: cartItems.length,
                              itemBuilder: (context, index) {
                                final item = cartItems[index];
                                final double itemPrice =
                                    double.tryParse(item['price'].toString()) ??
                                    0.0;
                                final int quantity = item['quantity'] ?? 1;

                                return Container(
                                  margin: const EdgeInsets.only(bottom: 14),
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: isDark
                                        ? const Color(0xFF1E1E1E)
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(18),
                                    boxShadow: isDark
                                        ? []
                                        : [
                                            BoxShadow(
                                              color: Colors.black.withValues(
                                                alpha: 0.02,
                                              ),
                                              blurRadius: 10,
                                              offset: const Offset(0, 4),
                                            ),
                                          ],
                                  ),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(14),
                                        child: Container(
                                          width: 68,
                                          height: 68,
                                          color: Colors.grey.shade100,
                                          child: item['image_path'] != null
                                              ? Image.asset(
                                                  item['image_path'],
                                                  fit: BoxFit.cover,
                                                  errorBuilder:
                                                      (
                                                        context,
                                                        error,
                                                        stackTrace,
                                                      ) {
                                                        return const Icon(
                                                          Icons
                                                              .fastfood_rounded,
                                                          color: Colors.grey,
                                                        );
                                                      },
                                                )
                                              : const Icon(
                                                  Icons.fastfood_rounded,
                                                  color: Colors.grey,
                                                ),
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item['item_name'] ??
                                                  'Food Product',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 6),
                                            Text(
                                              "Rs. ${(itemPrice * quantity).toStringAsFixed(2)}",
                                              style: TextStyle(
                                                color:
                                                    theme.colorScheme.primary,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: isDark
                                              ? Colors.black54
                                              : Colors.grey.shade50,
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            IconButton(
                                              icon: Icon(
                                                Icons.remove_rounded,
                                                color: Colors.grey.shade600,
                                                size: 18,
                                              ),
                                              onPressed: () => cartProvider
                                                  .decrementQuantity(
                                                    item['id'],
                                                  ),
                                            ),
                                            Text(
                                              "$quantity",
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            IconButton(
                                              icon: Icon(
                                                Icons.add_rounded,
                                                color:
                                                    theme.colorScheme.primary,
                                                size: 18,
                                              ),
                                              onPressed: () => cartProvider
                                                  .incrementQuantity(
                                                    item['id'],
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),

                          // total calculated check out footer
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? const Color(0xFF121212)
                                  : const Color(0xFFFAFAFA),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Total Amount",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey.shade500,
                                      ),
                                    ),
                                    Text(
                                      "Rs. ${cartProvider.totalAmount.toStringAsFixed(2)}",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: theme.colorScheme.primary,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                SizedBox(
                                  width: double.infinity,
                                  height: 52,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          theme.colorScheme.primary,
                                      foregroundColor: Colors.white,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),
                                    onPressed: orderProvider.isSubmitting
                                        ? null
                                        : () async {
                                            final prefs =
                                                await SharedPreferences.getInstance();
                                            final String? token = prefs
                                                .getString('auth_token');

                                            final List<Map<String, dynamic>>
                                            structuredCart = cartItems
                                                .map(
                                                  (e) =>
                                                      Map<String, dynamic>.from(
                                                        e,
                                                      ),
                                                )
                                                .toList();

                                            final bool success =
                                                await orderProvider.submitOrder(
                                                  cartItems: structuredCart,
                                                  totalAmount:
                                                      cartProvider.totalAmount,
                                                  authToken: token,
                                                );

                                            if (success) {
                                              final generatedOtp =
                                                  orderProvider
                                                      .activeOrder?['otp'] ??
                                                  'N/A';
                                              cartProvider.clearCart();

                                              if (context.mounted) {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) => AlertDialog(
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            24,
                                                          ),
                                                    ),
                                                    title: const Row(
                                                      children: [
                                                        Icon(
                                                          Icons
                                                              .check_circle_rounded,
                                                          color: Colors.green,
                                                          size: 28,
                                                        ),
                                                        SizedBox(width: 12),
                                                        Text(
                                                          "Order Placed!",
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    content: Text(
                                                      "Your order was securely saved to the canteen system.\n\nPresent this pickup validation OTP at the counter:\n\n OTP: $generatedOtp ",
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        height: 1.4,
                                                      ),
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                              context,
                                                            ),
                                                        child: const Text(
                                                          "Awesome",
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }
                                            } else {
                                              if (context.mounted) {
                                                ScaffoldMessenger.of(
                                                  context,
                                                ).showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      orderProvider
                                                              .errorMessage ??
                                                          "An error occurred placing your order.",
                                                    ),
                                                    backgroundColor:
                                                        Colors.redAccent,
                                                    behavior: SnackBarBehavior
                                                        .floating,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            10,
                                                          ),
                                                    ),
                                                  ),
                                                );
                                              }
                                            }
                                          },
                                    child: orderProvider.isSubmitting
                                        ? const SizedBox(
                                            width: 24,
                                            height: 24,
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                              strokeWidth: 2.5,
                                            ),
                                          )
                                        : const Text(
                                            "Place Order",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 0.5,
                                            ),
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
