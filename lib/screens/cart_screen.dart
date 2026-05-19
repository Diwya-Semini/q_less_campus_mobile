import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // set the default pickup time to 12:15 PM for the chips selection
  String selectedTime = "12:15 PM";

  // checkout item list
  final List<Map<String, dynamic>> cartItems = [
    {
      "name": "Fried Rice",
      "price": 650.00,
      "qty": 1,
      "img": "https://i.ytimg.com/vi/mgrQD1vum1k/maxresdefault.jpg",
    },
    {
      "name": "Ribbon Cake",
      "price": 100.00,
      "qty": 2,
      "img":
          "https://www.theflavorbender.com/wp-content/uploads/2018/03/Sri-Lankan-Ribbon-Cake-The-Flavor-Bender-Featured-Image-SQ-8.jpg",
    },
  ];

  @override
  Widget build(BuildContext context) {
    // color themes and setup
    final theme = Theme.of(context);
    final Color orange = theme.colorScheme.primary;
    final bool isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDark
            ? const Color.fromARGB(255, 30, 30, 30)
            : Colors.white,
        title: const Text(
          "Cart",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        color: isDark ? Colors.black : const Color(0xFFF5F5F5),
        // LayoutBuilder - adapt the layout based on screen width
        child: LayoutBuilder(
          builder: (context, constraints) {
            // If the screen is wider than 600px show the two panle
            if (constraints.maxWidth > 600) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // left panle - Cart
                  Expanded(flex: 3, child: _buildCartList(isDark, orange)),
                  const VerticalDivider(width: 1),
                  // right panle - Checkout
                  // Added height: because the ipad checkout is half the screen height
                  Expanded(
                    flex: 2,
                    child: _buildCheckoutPanel(
                      isDark,
                      orange,
                      isLandscape: true,
                    ),
                  ),
                ],
              );
            } else {
              // show the single column
              return Column(
                children: [
                  Expanded(child: _buildCartList(isDark, orange)),
                  // Wrapped in Flexible to prevent overflow
                  Flexible(
                    child: _buildCheckoutPanel(
                      isDark,
                      orange,
                      isLandscape: false,
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  // cart item list
  Widget _buildCartList(bool isDark, Color orange) {
    // screen for the list of items in the cart
    return ListView.builder(
      // gap between items and padding around the list
      padding: const EdgeInsets.all(15),
      itemCount: cartItems.length,
      itemBuilder: (context, index) {
        final item = cartItems[index];
        // item card
        return Card(
          margin: const EdgeInsets.only(bottom: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: isDark
              ? Colors.white.withValues(alpha: 0.1)
              : Colors.white, // card background color
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                // item image
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    item['img'],
                    width: 150,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['name'],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Rs. ${item['price']}",
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                // quantity controls
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove_circle_outline, size: 25),
                      onPressed: () {},
                    ),
                    Text(
                      "${item['qty']}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: Icon(Icons.add_circle, color: orange, size: 25),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // checkout panel
  // Added isLandscape parameter to control height behavior
  Widget _buildCheckoutPanel(
    bool isDark,
    Color orange, {
    bool isLandscape = false,
  }) {
    return Container(
      // make sure the background fills the entire vertical height in landscape mode
      height: isLandscape ? double.infinity : null,
      // contailer - pickup details, payment method, checkout button
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Pickup Details",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const Text(
              "Select Pickup Time",
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            const SizedBox(height: 15),

            // chips for time selection
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ChoiceChip(
                    label: const Text("12:15 PM"),
                    // maually select the time
                    selected: true,
                    selectedColor: orange,
                    labelStyle: const TextStyle(color: Colors.white),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    onSelected: (val) {},
                  ),
                  const SizedBox(width: 8),
                  ChoiceChip(
                    label: const Text("12:30 PM"),
                    selected: false,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    onSelected: (val) {},
                  ),
                  const SizedBox(width: 8),
                  ChoiceChip(
                    label: const Text("12:45 PM"),
                    selected: false,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    onSelected: (val) {},
                  ),
                  const SizedBox(width: 8),
                  ChoiceChip(
                    label: const Text("1:00 PM"),
                    selected: false,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    onSelected: (val) {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              "Payment Method",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 5),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.1)
                    : Colors.grey[200],
                borderRadius: BorderRadius.circular(15),
              ),
              // payment method dropdown
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: "Cash on Pickup",
                  isExpanded: true,
                  items: const [
                    DropdownMenuItem(
                      value: "Cash on Pickup",
                      child: Text("Cash on Pickup"),
                    ),
                  ],
                  onChanged: (val) {},
                ),
              ),
            ),
            const SizedBox(height: 20),

            // total and checkout button
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                color: orange,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // total amount
                  Row(
                    children: const [
                      Text(
                        "Total: ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Rs.750",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  // checkout button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      elevation: 0,
                      shape: const StadiumBorder(), // rounded button shape
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 10,
                      ),
                    ),
                    onPressed: () {},
                    child: const Text(
                      "Checkout",
                      style: TextStyle(fontWeight: FontWeight.bold),
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
