import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
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
  String _searchQuery = "";
  String _selectedCategory = "All";

  List<dynamic> _localJsonFallbackItems = [];
  bool _isAssetLoading = false;

  @override
  void initState() {
    super.initState();
    _loadLocalFallbackJson();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      Provider.of<MenuProvider>(
        context,
        listen: false,
      ).syncMenu(authProvider.canteenID);
    });
  }

  // --- READS DIRECTLY FROM LOCAL_MENU.JSON FILE ---
  Future<void> _loadLocalFallbackJson() async {
    if (!mounted) return;
    setState(() => _isAssetLoading = true);
    try {
      final String response = await rootBundle.loadString(
        'assets/data/local_menu.json',
      );
      final dynamic data = await json.decode(response);

      if (mounted && data is List) {
        setState(() {
          _localJsonFallbackItems = data;
        });
      }
    } catch (e) {
      debugPrint("Error reading assets/data/local_menu.json: $e");
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

                // Real-time Connectivity Warning Banner using connectivity_plus stream directly
                StreamBuilder<List<ConnectivityResult>>(
                  stream: Connectivity().onConnectivityChanged,
                  builder: (context, snapshot) {
                    final connectivityResult = snapshot.data;
                    final bool isHardwareOffline =
                        connectivityResult != null &&
                        !connectivityResult.contains(ConnectivityResult.wifi) &&
                        !connectivityResult.contains(ConnectivityResult.mobile);

                    if (isHardwareOffline) {
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
                        child: Row(
                          children: [
                            Icon(
                              Icons.wifi_off_rounded,
                              color: Colors.amber.shade800,
                              size: 18,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                "Offline Mode: Reading from local data assets",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.amber.shade800,
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

                _buildFoodGrid(context),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    final theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    return TextField(
      style: TextStyle(color: isDark ? Colors.white : Colors.black87),
      onChanged: (value) {
        setState(() => _searchQuery = value);
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

  Widget _buildCatItem(String label, IconData icon, Color color) {
    final bool isActive =
        _selectedCategory.toLowerCase() == label.toLowerCase();

    return GestureDetector(
      onTap: () {
        setState(() => _selectedCategory = label);
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

  Widget _buildFoodGrid(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Consumer<MenuProvider>(
      builder: (context, menuProvider, child) {
        if (menuProvider.isLoading || _isAssetLoading) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 60),
              child: CircularProgressIndicator.adaptive(),
            ),
          );
        }

        return StreamBuilder<List<ConnectivityResult>>(
          stream: Connectivity().onConnectivityChanged,
          builder: (context, connectivitySnapshot) {
            final connectivityResult = connectivitySnapshot.data;

            bool isDevicePhysicallyOffline = false;
            if (connectivityResult != null) {
              isDevicePhysicallyOffline =
                  !connectivityResult.contains(ConnectivityResult.wifi) &&
                  !connectivityResult.contains(ConnectivityResult.mobile);
            }

            // STRICT DATA SEGREGATION POOL SWITCH
            List<dynamic> sourceMenuPool = [];

            if (isDevicePhysicallyOffline || menuProvider.isOfflineMode) {
              sourceMenuPool = _localJsonFallbackItems;

              if (authProvider.canteenID != null && sourceMenuPool.isNotEmpty) {
                sourceMenuPool = sourceMenuPool.where((item) {
                  final String jsonCanteenId = (item['canteen_id'] ?? '')
                      .toString()
                      .trim();
                  final String activeCanteenId = authProvider.canteenID
                      .toString()
                      .trim();
                  return jsonCanteenId == activeCanteenId;
                }).toList();
              }
            } else {
              sourceMenuPool = menuProvider.menuItems;
            }

            // --- THE DYNAMIC MULTI-STAGE FILTER PIPELINE ---
            final List<dynamic> filteredLiveMenu = sourceMenuPool.where((item) {
              final String itemCategory = (item['category'] ?? '')
                  .toString()
                  .toLowerCase()
                  .trim();
              final String selectedClean = _selectedCategory
                  .toLowerCase()
                  .trim();

              final String normalItemCat = itemCategory.replaceAll('s', '');
              final String normalSelected = selectedClean.replaceAll('s', '');

              bool matchesCategory =
                  _selectedCategory == "All" ||
                  itemCategory == selectedClean ||
                  normalItemCat == normalSelected ||
                  itemCategory.contains(normalSelected);

              final String itemName = (item['item_name'] ?? '')
                  .toString()
                  .toLowerCase();
              final bool matchesSearch = itemName.contains(
                _searchQuery.toLowerCase().trim(),
              );

              return matchesCategory && matchesSearch;
            }).toList();

            if (filteredLiveMenu.isEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: Column(
                    children: [
                      Icon(
                        Icons.search_off_rounded,
                        color: Colors.grey.withValues(alpha: 0.5),
                        size: 40,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'No menu products match your filters.',
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: filteredLiveMenu.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.82,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
              ),
              itemBuilder: (context, index) {
                final rawItem = filteredLiveMenu[index];
                final Map<String, dynamic> cleanItem =
                    Map<String, dynamic>.from(rawItem);

                if (cleanItem['price'] is String) {
                  cleanItem['price'] =
                      double.tryParse(cleanItem['price'].toString()) ?? 0.00;
                }

                return FoodCard(
                  item: cleanItem,
                  isDark: Theme.of(context).brightness == Brightness.dark,
                  brandColor: Theme.of(context).colorScheme.primary,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FoodDetailScreen(item: cleanItem),
                      ),
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}
