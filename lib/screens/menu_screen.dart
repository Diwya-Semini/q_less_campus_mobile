import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:q_less_campus/providers/menu_provider.dart';
import 'package:q_less_campus/screens/food_detail_screen.dart';
import 'package:q_less_campus/widgets/custom_header.dart';
import 'package:q_less_campus/widgets/food_card.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  void initState() {
    super.initState();
    // connct backend controllers at launch
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MenuProvider>(context, listen: false).syncMenu();
    });
  }

  @override
  Widget build(BuildContext context) {
    // responsive Layout builder
    return LayoutBuilder(
      builder: (context, constraints) {
        final isLandscape = constraints.maxWidth > constraints.maxHeight;

        return SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomHeader(screenTitle: "Explore Menu"),
                const SizedBox(height: 20),
                _buildSearchBar(context),
                const SizedBox(height: 25),
                _buildCategorySection(context),
                const SizedBox(height: 25),

                // offline warning monitor
                Consumer<MenuProvider>(
                  builder: (context, provider, _) {
                    if (provider.isOfflineMode && !provider.isLoading) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 16,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.amber.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.amber.shade700,
                            width: 0.5,
                          ),
                        ),

                        child: Row(
                          children: [
                            Icon(
                              Icons.wifi_off_rounded,
                              color: Colors.amber.shade800,
                              size: 18,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              "Offline Mode: Reading from local data assets",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.amber.shade800,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),

                _buildFoodGrid(context, isLandscape: isLandscape),
              ],
            ),
          ),
        );
      },
    );
  }

  // search bar
  Widget _buildSearchBar(BuildContext context) {
    final theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    return TextField(
      style: TextStyle(color: isDark ? Colors.white : Colors.black87),
      decoration: InputDecoration(
        hintText: "Search your favoirites....",
        hintStyle: TextStyle(
          color: isDark ? Colors.grey : Colors.grey.shade500,
        ),
        prefixIcon: Icon(
          Icons.search_rounded,
          size: 22,
          color: theme.colorScheme.primary,
        ),
        filled: true,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 20,
        ),
        fillColor: isDark
            ? Colors.white.withOpacity(0.07)
            : const Color(0xFFF3F3F3),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }

  // category Menu Row
  Widget _buildCategorySection(BuildContext context) {
    final theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;
    final Color primaryColor = theme.colorScheme.primary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Explore Category",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),

        const SizedBox(height: 15),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: [
              _buildCatItem(
                "All",
                Icons.restaurant_rounded,
                primaryColor,
                true,
              ),
              _buildCatItem(
                "Main",
                Icons.rice_bowl_rounded,
                const Color(0xFFA5672C),
                false,
              ),
              _buildCatItem(
                "Pastry",
                Icons.bakery_dining_rounded,
                const Color(0xFFA5672C),
                false,
              ),
              _buildCatItem(
                "Dessert",
                Icons.cake_rounded,
                const Color(0xFFA5672C),
                false,
              ),
              _buildCatItem(
                "Drink",
                Icons.local_drink_rounded,
                const Color(0xFFA5672C),
                false,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCatItem(
    String lable,
    IconData icon,
    Color color,
    bool isActive,
  ) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Column(
        children: [
          CircleAvatar(
            radius: 26,
            backgroundColor: isActive
                ? const Color(0xFFFDA750)
                : const Color(0xFFFCE6C9).withOpacity(0.3),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 8),
          Text(
            lable,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
              color: isActive ? color : Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFoodGrid(BuildContext context, {required bool isLandscape}) {
    return Consumer<MenuProvider>(
      builder: (context, menuProvider, child) {
        // loading state
        if (menuProvider.isLoading) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 60),
              child: CircularProgressIndicator.adaptive(),
            ),
          );
        }

        // empty state
        if (menuProvider.menuItems.isEmpty) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 40),
              child: Text(
                'No menu products available in this session.',
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        }

        final liveMenu = menuProvider.menuItems;

        return GridView.builder(
          shrinkWrap: true,
          physics:
              const NeverScrollableScrollPhysics(), // Disables inner scrolling it scrolls smoothly inside the SingleChildScrollView
          itemCount: liveMenu.length,

          // controls how many columns to show
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: isLandscape ? 3 : 2,
            childAspectRatio: isLandscape ? 1.05 : 0.82,
            crossAxisSpacing: 14, // Spacing between columns
            mainAxisSpacing: 14, // Spacing between rows
          ),

          itemBuilder: (context, index) {
            final item = liveMenu[index];

            return FoodCard(
              item: item,
              isDark: Theme.of(context).brightness == Brightness.dark,
              brandColor: Theme.of(context).colorScheme.primary,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FoodDetailScreen(item: item),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
