import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/order_provider.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : const Color(0xFFFAFAFA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Order Tracker", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black87)),
              Text("Live security validation profiles (Online Only)", style: TextStyle(fontSize: 12, color: Colors.grey.shade500)),
              const SizedBox(height: 25),

              Expanded(
                // REACTIVE CONSUMER TUNED TO ORDER PROCESSING SNAPSHOT RECORDS
                child: Consumer<OrderProvider>(
                  builder: (context, orderProvider, _) {
                    final liveOrder = orderProvider.activeOrder;

                    return ListView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                        if (liveOrder != null) ...[
                          _buildOrderCard(
                            theme, isDark,
                            orderId: "#QL-${liveOrder['id']}",
                            date: "Just Now",
                            items: "Active Processing Kitchen Queue Request",
                            total: "Rs. ${double.tryParse(liveOrder['total_amount'].toString())?.toStringAsFixed(2) ?? '0.00'}",
                            otpCode: liveOrder['otp'].toString(), // LIVE DYNAMIC OTP FROM LARAVEL CONTROLLER
                            statusText: liveOrder['status'].toString().toUpperCase(),
                            isCollected: false,
                          ),
                          const SizedBox(height: 20),
                          Text("Previous History", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey.shade500)),
                          const SizedBox(height: 10),
                        ],

                        _buildOrderCard(
                          theme, isDark,
                          orderId: "#QL-8210",
                          date: "Yesterday, 4:15 PM",
                          items: "2x Fish Patties, 1x Milo Shaker",
                          total: "Rs. 620.00",
                          otpCode: "DONE",
                          statusText: "COLLECTED",
                          isCollected: true,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderCard(ThemeData theme, bool isDark, {
    required String orderId, required String date, required String items, 
    required String total, required String otpCode, required String statusText, required bool isCollected
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(orderId, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: isCollected ? Colors.grey.withValues(alpha: 0.1) : Colors.amber.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  statusText,
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: isCollected ? Colors.grey : Colors.amber.shade800),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(date, style: TextStyle(color: Colors.grey.shade500, fontSize: 11)),
          const Padding(padding: EdgeInsets.symmetric(vertical: 8), child: Divider(height: 1)),
          Text(items, style: TextStyle(fontSize: 13, color: isDark ? Colors.grey.shade300 : Colors.grey.shade700)),
          const SizedBox(height: 6),
          Text(total, style: TextStyle(fontWeight: FontWeight.w800, color: theme.colorScheme.primary)),
          const SizedBox(height: 12),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Collection OTP Key:", style: TextStyle(fontSize: 12, color: Colors.grey.shade500, fontWeight: FontWeight.w500)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: isCollected ? Colors.grey.withValues(alpha: 0.1) : Colors.green.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  otpCode,
                  style: TextStyle(
                    fontSize: 13, 
                    fontWeight: FontWeight.bold, 
                    color: isCollected ? Colors.grey : Colors.green,
                    letterSpacing: isCollected ? 0 : 2,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}