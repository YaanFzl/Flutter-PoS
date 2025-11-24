import 'package:flutter/material.dart';
import 'screens/dashboard_screen.dart';
import 'screens/delivery/delivery_integration_screen.dart';
import 'screens/menu/menu_management_screen.dart';
import 'theme/app_colors.dart';
import 'widgets/main_layout.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DineDash',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        useMaterial3: true,
        fontFamily: 'Be Vietnam Pro',
      ),
      home: const HomeScreen(),
    );
  }
}

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
