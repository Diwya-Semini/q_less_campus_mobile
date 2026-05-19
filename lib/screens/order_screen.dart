import 'package:flutter/material.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  // Appropriate campus content - Every item MUST have an 'otp' key
  final List<Map<String, dynamic>> orderHistory = const [
    {
      "name": "Chicken Fried Rice",
      "date": "15 Feb 2026",
      "price": "Rs. 650",
      "status": "Ready for Pickup",
      "otp": "4592",
      "img": "https://i.ytimg.com/vi/mgrQD1vum1k/maxresdefault.jpg",
    },
    {
      "name": "Veggie Pasta",
      "date": "14 Feb 2026",
      "price": "Rs. 450",
      "status": "Completed",
      "otp": "8120",
      "img":
          "https://www.indianveggiedelight.com/wp-content/uploads/2019/09/creamy_tomato_pasta_1.jpg",
    },
  ];

  @override
  Widget build(BuildContext context) {
    // theme colors for dark/light mode
    final theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;
    final Color orange = theme.colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Orders",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
      ),
      body: Container(
        color: isDark ? Colors.black : const Color(0xFFF5F5F5),
        // go through the order history and display each order in a card
        child: ListView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: orderHistory.length,
          itemBuilder: (context, index) {
            final order = orderHistory[index];
            bool isReady = order['status'] == "Ready for Pickup";

            return Card(
              color: isDark ? const Color(0xFF2C2C2C) : Colors.white,
              margin: const EdgeInsets.only(bottom: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(12),
                // order details
                child: Row(
                  children: [
                    // order image with rounded corners
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        order['img'],
                        width: 150,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 15),
                    // order name, OTP badge, price and status
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            order['name'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: orange.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              order['otp'] ??
                                  '0000', // Uses 0000 if data is null to prevent crash
                              style: TextStyle(
                                color: orange,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          order['price'],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          order['status'],
                          style: TextStyle(
                            color: isReady ? orange : Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
