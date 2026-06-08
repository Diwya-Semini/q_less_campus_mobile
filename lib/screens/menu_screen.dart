import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Crucial for reading root bundle assets
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:q_less_campus/providers/auth_provider.dart';
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
  // Core runtime filter state variables
  String _searchQuery = "";
  String _selectedCategory = "All";

  // State state list to store decoded data from assets
  List<dynamic> _localJsonFallbackItems = [];
  bool _isAssetLoading = false;

  @override
  void initState() {
    super.initState();
    _loadLocalFallbackJson(); // Pre-loads the required offline dataset into memory cleanly

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      Provider.of<MenuProvider>(
        context,
        listen: false,
      ).syncMenu(authProvider.canteenID);
    });
  }

  // --- ASSET PIPELINE READ METHOD ---
  // Reads, decodes, and populates data records straight from local_menu.json
  Future<void> _loadLocalFallbackJson() async {
    setState(() => _isAssetLoading = true);
    try {
      final String response = await rootBundle.loadString(
        'assets/data/local_menu.json',
      );
      final data = await json.decode(response);
      if (mounted) {
        setState(() {
          _localJsonFallbackItems = data['menu_items'] ?? data;
        });
      }
    } catch (e) {
      debugPrint(
        "Error loading structural local_menu.json data asset file: $e",
      );
    } finally {
      if (mounted) {
        setState(() => _isAssetLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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

                // Offline warning monitor banner
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
                          color: Colors.amber.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.amber.shade700,
                            width: 0.5,
                          ),
                        ),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.wifi_off_rounded,
                              color: Colors.amber,
                              size: 18,
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                "Offline Mode: Reading from local data assets",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.amber,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),

                // Live filtering grid execution
                _buildFoodGrid(context, isLandscape: isLandscape),
              ],
            ),
          ),
        );
      },
    );
  }

  // Search Bar component
  Widget _buildSearchBar(BuildContext context) {
    final theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    return TextField(
      style: TextStyle(color: isDark ? Colors.white : Colors.black87),
      onChanged: (value) {
        setState(() {
          _searchQuery = value; // Triggers list filters instantly on key input
        });
      },
      decoration: InputDecoration(
        hintText: "Search your favorites....",
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
            ? Colors.white.withValues(alpha: 0.07)
            : const Color(0xFFF3F3F3),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }

  // Interactive Category Builder Row Section
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
              _buildCatItem("All", Icons.restaurant_rounded, primaryColor),
              _buildCatItem(
                "Mains",
                Icons.rice_bowl_rounded,
                const Color(0xFFA5672C),
              ),
              _buildCatItem(
                "Pastry",
                Icons.bakery_dining_rounded,
                const Color(0xFFA5672C),
              ),
              _buildCatItem(
                "Snacks",
                Icons.cake_rounded,
                const Color(0xFFA5672C),
              ),
              _buildCatItem(
                "Drinks",
                Icons.local_drink_rounded,
                const Color(0xFFA5672C),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Category Pill Item supporting dynamic interactivity states
  Widget _buildCatItem(String label, IconData icon, Color color) {
    final bool isActive =
        _selectedCategory.toLowerCase() == label.toLowerCase();

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategory = label; // Sets current target selection state
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 20),
        child: Column(
          children: [
            CircleAvatar(
              radius: 26,
              backgroundColor: isActive
                  ? const Color(0xFFFDA750)
                  : const Color(0xFFFCE6C9).withValues(alpha: 0.3),
              child: Icon(
                icon,
                color: isActive ? Colors.white : color,
                size: 24,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                color: isActive
                    ? const Color(0xFFFDA750)
                    : Colors.grey.shade500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Combined State Filtering Pipeline Grid
  Widget _buildFoodGrid(BuildContext context, {required bool isLandscape}) {
    return Consumer<MenuProvider>(
      builder: (context, menuProvider, child) {
        // Handle basic background asset loading indicators safely
        if (menuProvider.isLoading || _isAssetLoading) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 60),
              child: CircularProgressIndicator.adaptive(),
            ),
          );
        }

        // SWAP DATABASES POOL ACCORDING TO TELEMETRY SIGNALS
        final List<dynamic> sourceMenuPool = menuProvider.isOfflineMode
            ? _localJsonFallbackItems
            : menuProvider.menuItems;

        // --- THE DYNAMIC MULTI-STAGE FILTER PIPELINE ---
        final List<dynamic> filteredLiveMenu = sourceMenuPool.where((item) {
          final String itemCategory = (item['category'] ?? '')
              .toString()
              .toLowerCase();
          final String selectedClean = _selectedCategory.toLowerCase();

          final bool matchesCategory =
              _selectedCategory == "All" ||
              itemCategory == selectedClean ||
              itemCategory.replaceAll('s', '') ==
                  selectedClean.replaceAll('s', '');

          final String itemName = (item['item_name'] ?? '')
              .toString()
              .toLowerCase();
          final bool matchesSearch = itemName.contains(
            _searchQuery.toLowerCase(),
          );

          return matchesCategory && matchesSearch;
        }).toList();

        if (filteredLiveMenu.isEmpty) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 40),
              child: Text(
                'No menu products match your filters.',
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        }

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: filteredLiveMenu.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: isLandscape ? 3 : 2,
            childAspectRatio: isLandscape ? 1.05 : 0.82,
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
          ),
          itemBuilder: (context, index) {
            final item = filteredLiveMenu[index];

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
