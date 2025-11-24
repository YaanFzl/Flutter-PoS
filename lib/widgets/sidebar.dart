import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

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
              children: const [
                NavItem(
                  icon: Icons.grid_view,
                  label: 'Semua Pesanan',
                  count: 7,
                  isActive: false,
                ),
                SizedBox(height: 12),
                NavItem(
                  icon: Icons.notifications_active,
                  label: 'Baru',
                  count: 3,
                  isActive: true,
                ),
                SizedBox(height: 12),
                NavItem(
                  icon: Icons.soup_kitchen,
                  label: 'Memasak',
                  count: 2,
                  isActive: false,
                ),
                SizedBox(height: 12),
                NavItem(
                  icon: Icons.check_circle,
                  label: 'Siap',
                  count: 2,
                  isActive: false,
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

  const NavItem({
    super.key,
    required this.icon,
    required this.label,
    required this.count,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: isActive ? AppColors.primary.withAlpha(51) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: isActive ? AppColors.primary : AppColors.textLight,
          ),
          const SizedBox(width: 16),
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isActive ? AppColors.primary : AppColors.textLight,
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: isActive ? AppColors.primary : Colors.black.withAlpha(13),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              count.toString(),
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: isActive ? AppColors.textLight : AppColors.textLight,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
