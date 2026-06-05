import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:q_less_campus/providers/menu_provider.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  void initState() {
    super. initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      Provider.of<MenuProvider>(context, listen: false).syncMenu();
    });
  }

  @override
  Widget build(BuildContext context) {
    // theams and acceessability color management
    final theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;
    final Color brandOrange = theme.colorScheme.primary;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : const Color(0xFFFAFAFA),
      body: LayoutBuilder(
        builder: (context, constraints){
          final isLandscape = constraints.maxWidth > constraints.maxHeight;
          return _buildContent(context, isDark, brandOrange, isLandscape);
        },
      ),
    );
  }

  
}