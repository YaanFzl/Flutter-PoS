import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class Sidebar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onDestinationSelected;
  final int allOrdersCount;
  final int kitchenOrdersCount;
  final VoidCallback? onLogout;

  const Sidebar({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
    this.allOrdersCount = 0,
    this.kitchenOrdersCount = 0,
    this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          width: 280,
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(150), // 0.6 opacity
            border: Border(
              right: BorderSide(
                color: Colors.white.withAlpha(100),
                width: 1,
              ),
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 40),
              // Logo Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [AppColors.primary, Color(0xFF0EB545)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withAlpha(77),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Icon(Icons.restaurant_menu, color: Colors.white, size: 24),
                    ),
                    const SizedBox(width: 16),
                    const Text(
                      'DineDash',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textLight,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 50),
              
              // Navigation
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    _buildSectionHeader('MENU UTAMA'),
                    const SizedBox(height: 16),
                    NavItem(
                      icon: Icons.grid_view_rounded,
                      label: 'Semua Pesanan',
                      count: allOrdersCount,
                      isActive: selectedIndex == 0,
                      onTap: () => onDestinationSelected(0),
                    ),
                    const SizedBox(height: 8),
                    NavItem(
                      icon: Icons.soup_kitchen_rounded,
                      label: 'Dapur',
                      count: kitchenOrdersCount,
                      isActive: selectedIndex == 1,
                      onTap: () => onDestinationSelected(1),
                    ),
                    const SizedBox(height: 8),
                    NavItem(
                      icon: Icons.restaurant_rounded,
                      label: 'Menu',
                      count: 0,
                      isActive: selectedIndex == 2,
                      onTap: () => onDestinationSelected(2),
                    ),
                    
                    const SizedBox(height: 32),
                    _buildSectionHeader('LAINNYA'),
                    const SizedBox(height: 16),
                    NavItem(
                      icon: Icons.settings_rounded,
                      label: 'Pengaturan',
                      count: 0,
                      isActive: selectedIndex == 3,
                      onTap: () => onDestinationSelected(3),
                    ),
                  ],
                ),
              ),
              
              // Logout Profile Section
              Padding(
                padding: const EdgeInsets.all(24),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(128),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white),
                  ),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        backgroundColor: AppColors.textMutedLight,
                        radius: 20,
                        child: Icon(Icons.person, color: Colors.white),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Admin Kasir',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: AppColors.textLight,
                              ),
                            ),
                            Text(
                              'Online',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Material(
                        type: MaterialType.transparency,
                        child: IconButton(
                          onPressed: onLogout,
                          icon: const Icon(Icons.logout_rounded, color: Colors.redAccent),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: AppColors.textMutedLight.withAlpha(150),
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}

class NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final int count;
  final bool isActive;
  final VoidCallback onTap;

  const NavItem({
    super.key,
    required this.icon,
    required this.label,
    required this.count,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: isActive ? AppColors.primary : Colors.transparent,
        borderRadius: BorderRadius.circular(14),
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: AppColors.primary.withAlpha(77),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ]
            : [],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: isActive ? Colors.white : AppColors.textMutedLight,
                  size: 22,
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                      color: isActive ? Colors.white : AppColors.textMutedLight,
                      fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                ),
                if (count > 0)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: isActive ? Colors.white.withAlpha(51) : AppColors.primary.withAlpha(26),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      count.toString(),
                      style: TextStyle(
                        color: isActive ? Colors.white : AppColors.primary,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
