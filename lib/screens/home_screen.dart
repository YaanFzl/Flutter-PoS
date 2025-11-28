import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'dashboard_screen.dart';
import 'delivery/delivery_integration_screen.dart';
import 'menu/menu_management_screen.dart';
import 'settings/settings_screen.dart';
import '../widgets/main_layout.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  int _allOrdersCount = 0;
  int _kitchenOrdersCount = 0;
  final _apiService = ApiService();

  Future<void> _handleLogout() async {
    await _apiService.logout();
    if (mounted) {
      Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Rebuild screens to pass callbacks
    final screens = [
      DashboardScreen(
        onCountChanged: (count) {
          if (_allOrdersCount != count) {
            // Schedule update to avoid build conflicts
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) setState(() => _allOrdersCount = count);
            });
          }
        },
      ),
      DeliveryIntegrationScreen(
        onCountChanged: (count) {
          if (_kitchenOrdersCount != count) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) setState(() => _kitchenOrdersCount = count);
            });
          }
        },
      ),
      const MenuManagementScreen(),
      const SettingsScreen(),
    ];

    return MainLayout(
      selectedIndex: _selectedIndex,
      onDestinationSelected: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      allOrdersCount: _allOrdersCount,
      kitchenOrdersCount: _kitchenOrdersCount,
      onLogout: _handleLogout,
      child: screens[_selectedIndex],
    );
  }
}
