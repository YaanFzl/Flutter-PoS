import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class Sidebar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onDestinationSelected;

  const Sidebar({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250, // sm:w-64
      color: AppColors.surfaceLight,
      child: Column(
        children: [
          const SizedBox(height: 24),
          // Logo
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                const Icon(Icons.restaurant_menu, color: AppColors.primary, size: 32),
                const SizedBox(width: 8),
                const Text(
                  'DineDash',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textLight,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          // Navigation
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                NavItem(
                  icon: Icons.grid_view,
                  label: 'Semua Pesanan',
                  count: 7,
                  isActive: selectedIndex == 0,
                  onTap: () => onDestinationSelected(0),
                ),
                const SizedBox(height: 12),
                NavItem(
                  icon: Icons.soup_kitchen,
                  label: 'Dapur',
                  count: 2,
                  isActive: selectedIndex == 1,
                  onTap: () => onDestinationSelected(1),
                ),
                const SizedBox(height: 12),
                NavItem(
                  icon: Icons.restaurant,
                  label: 'Menu',
                  count: 0,
                  isActive: selectedIndex == 2,
                  onTap: () => onDestinationSelected(2),
                ),
              ],
            ),
          ),
          // Logout
          Padding(
            padding: const EdgeInsets.all(16),
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(8),
              child: Container(
                height: 56,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.logout, color: AppColors.textLight),
                    const SizedBox(width: 16),
                    const Text(
                      'Keluar',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textLight,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
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
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isActive ? Colors.white : AppColors.textMutedLight,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: isActive ? Colors.white : AppColors.textMutedLight,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (count > 0)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: isActive ? Colors.white.withAlpha(51) : AppColors.primary.withAlpha(26),
                  borderRadius: BorderRadius.circular(12),
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
    );
  }
}
