import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:q_less_campus/providers/order_provider.dart';
import 'package:q_less_campus/screens/cart_screen.dart';
import 'package:q_less_campus/screens/menu_screen.dart';
import 'package:q_less_campus/screens/order_history_screen.dart';
import 'package:q_less_campus/screens/profile_screen.dart';

class NavigationHub extends StatefulWidget {
  const NavigationHub({super.key});

  @override
  State<NavigationHub> createState() => _NavigationHubState();
}

class _NavigationHubState extends State<NavigationHub> {
  // Track the currently selected page index for navigation
  int _currentIndex = 0;

  // screens list for navigation
  final List<Widget> _pages = [
    const MenuScreen(),
    const CartScreen(),
    const OrderHistoryScreen(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();

    // Executes background pipeline fetches right after framework assembly
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        final prefs = await SharedPreferences.getInstance();
        final String? token = prefs.getString('auth_token');

        if (mounted) {
          // fetch all student orders
          await Provider.of<OrderProvider>(
            context,
            listen: false,
          ).fetchLiveOrdersFromDB(token);
        }
      } catch (e) {
        debugPrint("Initial structural database history prefetch failed: $e");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    const Color brandNavy = Color(0xFF050D2E);

    return LayoutBuilder(
      builder: (context, constraints) {
        // landscape split view with side nav
        if (constraints.maxWidth > 600) {
          return Scaffold(
            body: Row(
              children: [
                Expanded(child: _pages[_currentIndex]),
                _buildLandscapeNav(isDark, brandNavy),
              ],
            ),
          );
        }
        // portrait with bottom nav
        else {
          return Scaffold(
            body: _pages[_currentIndex],
            bottomNavigationBar: _buildPortraitNav(isDark, brandNavy),
          );
        }
      },
    );
  }

  // landscape nav bar
  Widget _buildLandscapeNav(bool isDark, Color navy) {
    return Container(
      width: 90,
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF121212) : Colors.white,
        border: Border(
          left: BorderSide(color: Colors.grey.withValues(alpha: 0.1)),
        ),
      ),
      child: NavigationRail(
        selectedIndex: _currentIndex,
        // Update selected index on tap
        onDestinationSelected: (index) => setState(() => _currentIndex = index),
        labelType: NavigationRailLabelType.all,
        backgroundColor: Colors.transparent,
        // Active tab styling
        indicatorColor: navy.withValues(alpha: 0.1),
        selectedIconTheme: IconThemeData(
          color: isDark ? Colors.white : navy,
          size: 28,
        ),
        unselectedIconTheme: const IconThemeData(
          color: Color(0xFF4C4C4C),
          size: 24,
        ),
        groupAlignment: 0.0,
        destinations: const [
          NavigationRailDestination(
            icon: Icon(Icons.restaurant_menu_rounded),
            label: Text("Menu"),
          ),
          NavigationRailDestination(
            icon: Icon(Icons.shopping_cart_outlined),
            label: Text("Cart"),
          ),
          NavigationRailDestination(
            icon: Icon(Icons.receipt_long_outlined),
            label: Text("Orders"),
          ),
          NavigationRailDestination(
            icon: Icon(Icons.person_outline_rounded),
            label: Text("Profile"),
          ),
        ],
      ),
    );
  }

  // portrait nav bar
  Widget _buildPortraitNav(bool isDark, Color navy) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF121212) : Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: _currentIndex,
        // Update selected index on tap
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedItemColor: isDark ? Colors.white : navy,
        unselectedItemColor: const Color(0xFF4C4C4C),
        selectedFontSize: 12,
        unselectedFontSize: 12,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_menu_rounded),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
