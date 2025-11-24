import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'sidebar.dart';

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
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
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
}
