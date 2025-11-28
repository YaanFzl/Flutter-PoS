import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'sidebar.dart';
import '../widgets/common/premium_background.dart';

class MainLayout extends StatefulWidget {
  final Widget child;
  final int selectedIndex;
  final Function(int) onDestinationSelected;

  const MainLayout({
    super.key,
    required this.child,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  @override
  Widget build(BuildContext context) {
    return PremiumBackground(
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            // Mobile Layout
            return Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.white.withAlpha(200), // Glassy App Bar
                elevation: 0,
                iconTheme: const IconThemeData(color: AppColors.textLight),
                title: const Text(
                  'DineDash',
                  style: TextStyle(
                    color: AppColors.textLight,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                bottom: const PreferredSize(
                  preferredSize: Size.fromHeight(1),
                  child: Divider(height: 1, color: Colors.black12),
                ),
              ),
              drawer: Drawer(
                backgroundColor: Colors.transparent, // Transparent for glass effect
                elevation: 0,
                child: Sidebar(
                  selectedIndex: widget.selectedIndex,
                  onDestinationSelected: (index) {
                    widget.onDestinationSelected(index);
                    Navigator.pop(context); // Close drawer
                  },
                ),
              ),
              body: widget.child,
            );
          } else {
            // Desktop/Tablet Layout
            return Scaffold(
              backgroundColor: Colors.transparent,
              body: Row(
                children: [
                  Sidebar(
                    selectedIndex: widget.selectedIndex,
                    onDestinationSelected: widget.onDestinationSelected,
                  ),
                  Expanded(
                    child: widget.child,
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
