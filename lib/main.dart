import 'package:flutter/material.dart';
import 'screens/dashboard/dashboard_screen.dart';
import 'screens/payment/payment_selection_screen.dart';
import 'screens/payment/payment_confirmation_screen.dart';
import 'screens/delivery/delivery_integration_screen.dart';
import 'screens/delivery/delivery_order_details_screen.dart';
import 'screens/menu/menu_management_screen.dart';
import 'theme/app_colors.dart';

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
    const PaymentSelectionScreen(),
    const PaymentConfirmationScreen(),
    const DeliveryIntegrationScreen(),
    const DeliveryOrderDetailsScreen(),
    const MenuManagementScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            labelType: NavigationRailLabelType.all,
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.dashboard),
                label: Text('Dasbor'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.payment),
                label: Text('Pilih Bayar'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.check_circle),
                label: Text('Konfirmasi'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.delivery_dining),
                label: Text('Pengiriman'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.receipt_long),
                label: Text('Detail Order'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.menu_book),
                label: Text('Menu'),
              ),
            ],
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: _screens[_selectedIndex],
          ),
        ],
      ),
    );
  }
}
