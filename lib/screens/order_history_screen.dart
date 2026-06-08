import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:q_less_campus/providers/order_provider.dart';
import 'package:q_less_campus/widgets/custom_header.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'order_detail_screen.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  // method to trigger the refresh cleanly
  Future<void> _handleRefresh(BuildContext context) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('auth_token');
      if (context.mounted) {
        await Provider.of<OrderProvider>(
          context,
          listen: false,
        ).fetchLiveOrdersFromDB(token);
      }
    } catch (e) {
      debugPrint("Refresh failed: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    // Grab the reactive database order tracking layer
    final orderProvider = Provider.of<OrderProvider>(context, listen: true);
    final databaseOrders = orderProvider.databaseOrders;

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
              const CustomHeader(screenTitle: "Order History"),
              const SizedBox(height: 20),

              // Dynamic content container blocks
              Expanded(
                child: orderProvider.isLoading && databaseOrders.isEmpty
                    ? const Center(child: CircularProgressIndicator.adaptive())
                    : databaseOrders.isEmpty
                    ? Center(
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.receipt_long_rounded,
                                size: 55,
                                color: Colors.grey.shade400,
                              ),
                              const SizedBox(height: 14),
                              Text(
                                "No past orders found in database.",
                                style: TextStyle(color: Colors.grey.shade500),
                              ),
                              const SizedBox(height: 14),
                              ElevatedButton.icon(
                                onPressed: () => _handleRefresh(context),
                                icon: const Icon(
                                  Icons.refresh_rounded,
                                  size: 16,
                                ),
                                label: const Text("Tap to Refresh"),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: theme.colorScheme.primary,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : RefreshIndicator(
                        onRefresh: () => _handleRefresh(context),
                        child: ListView.builder(
                          padding: const EdgeInsets.only(top: 10, bottom: 20),
                          physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics(),
                          ),
                          itemCount: databaseOrders.length,
                          itemBuilder: (context, index) {
                            final order = databaseOrders[index];

                            String displayDate = "Just Now";
                            if (order['created_at'] != null) {
                              final parsedDate = DateTime.tryParse(
                                order['created_at'].toString(),
                              );
                              if (parsedDate != null) {
                                displayDate =
                                    "${parsedDate.day}/${parsedDate.month} at ${parsedDate.hour}:${parsedDate.minute.toString().padLeft(2, '0')}";
                              }
                            }

                            final String currentStatus =
                                (order['status'] ?? 'pending').toString();

                            return GestureDetector(
                              onTap: () {
                                final Map<String, dynamic> orderMap =
                                    Map<String, dynamic>.from(order);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        OrderDetailScreen(order: orderMap),
                                  ),
                                );
                              },
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 14),
                                padding: const EdgeInsets.all(16),
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
                                    Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: theme.colorScheme.primary
                                            .withValues(alpha: 0.08),
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                      child: Icon(
                                        Icons.fastfood_rounded,
                                        color: theme.colorScheme.primary,
                                        size: 22,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Order ID: #${order['id']}",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            "OTP Token: ${order['otp'] ?? 'N/A'}",
                                            style: TextStyle(
                                              color: Colors.grey.shade500,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            displayDate,
                                            style: TextStyle(
                                              color: Colors.grey.shade400,
                                              fontSize: 11,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          "Rs. ${double.parse(order['total_amount'].toString()).toStringAsFixed(2)}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: theme.colorScheme.primary,
                                            fontSize: 15,
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: currentStatus == 'completed'
                                                ? Colors.blue.withValues(
                                                    alpha: 0.1,
                                                  )
                                                : Colors.amber.withValues(
                                                    alpha: 0.1,
                                                  ),
                                            borderRadius: BorderRadius.circular(
                                              6,
                                            ),
                                          ),
                                          child: Text(
                                            currentStatus.toUpperCase(),
                                            style: TextStyle(
                                              color:
                                                  currentStatus == 'completed'
                                                  ? Colors.blue
                                                  : Colors.amber.shade800,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                            ),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
