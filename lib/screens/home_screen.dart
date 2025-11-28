import 'package:flutter/material.dart';
import 'dashboard_screen.dart';
import 'delivery/delivery_integration_screen.dart';
import 'menu/menu_management_screen.dart';
import '../widgets/main_layout.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const DashboardScreen(),
    const DeliveryIntegrationScreen(),
    const MenuManagementScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      selectedIndex: _selectedIndex,
      onDestinationSelected: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: _screens[_selectedIndex],
    );
  }
}
