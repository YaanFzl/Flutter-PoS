import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../widgets/common/glass_card.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _darkMode = false;
  bool _notifications = true;
  bool _sound = true;
  bool _printerConnected = true;
  bool _customerDisplayConnected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 800;
          final padding = isMobile ? 16.0 : 32.0;

          return SingleChildScrollView(
            padding: EdgeInsets.all(padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Pengaturan',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textLight,
                  ),
                ),
                SizedBox(height: padding),
                
                // Profile Section
                GlassCard(
                  padding: const EdgeInsets.all(24),
                  child: Row(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.shade200,
                          image: const DecorationImage(
                            image: NetworkImage('https://i.pravatar.cc/300'), // Placeholder
                            fit: BoxFit.cover,
                          ),
                          border: Border.all(color: Colors.white, width: 4),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(26),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Admin Restoran',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textLight,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Manager',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary.withAlpha(26),
                          foregroundColor: AppColors.primary,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(color: AppColors.primary.withAlpha(77)),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        ),
                        child: const Text('Edit Profil'),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Settings Grid
                isMobile 
                  ? Column(
                      children: [
                        _buildGeneralSettings(),
                        const SizedBox(height: 24),
                        _buildDeviceSettings(),
                      ],
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: _buildGeneralSettings()),
                        const SizedBox(width: 24),
                        Expanded(child: _buildDeviceSettings()),
                      ],
                    ),
                    
                const SizedBox(height: 24),
                
                // App Info
                Center(
                  child: Text(
                    'Stitch POS v1.0.0',
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildGeneralSettings() {
    return GlassCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Umum',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textLight,
            ),
          ),
          const SizedBox(height: 24),
          _buildSwitchTile(
            title: 'Mode Gelap',
            subtitle: 'Tampilan aplikasi gelap',
            icon: Icons.dark_mode_outlined,
            value: _darkMode,
            onChanged: (v) => setState(() => _darkMode = v),
          ),
          _buildDivider(),
          _buildSwitchTile(
            title: 'Notifikasi',
            subtitle: 'Terima notifikasi pesanan',
            icon: Icons.notifications_outlined,
            value: _notifications,
            onChanged: (v) => setState(() => _notifications = v),
          ),
          _buildDivider(),
          _buildSwitchTile(
            title: 'Suara',
            subtitle: 'Efek suara tombol',
            icon: Icons.volume_up_outlined,
            value: _sound,
            onChanged: (v) => setState(() => _sound = v),
          ),
        ],
      ),
    );
  }

  Widget _buildDeviceSettings() {
    return GlassCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Perangkat',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textLight,
            ),
          ),
          const SizedBox(height: 24),
          _buildDeviceTile(
            title: 'Printer Kasir',
            subtitle: _printerConnected ? 'Terhubung' : 'Terputus',
            icon: Icons.print_outlined,
            isConnected: _printerConnected,
            onTap: () => setState(() => _printerConnected = !_printerConnected),
          ),
          _buildDivider(),
          _buildDeviceTile(
            title: 'Customer Display',
            subtitle: _customerDisplayConnected ? 'Terhubung' : 'Terputus',
            icon: Icons.monitor_outlined,
            isConnected: _customerDisplayConnected,
            onTap: () => setState(() => _customerDisplayConnected = !_customerDisplayConnected),
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.primary.withAlpha(26),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppColors.primary, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textLight,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeTrackColor: AppColors.primary,
            activeThumbColor: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget _buildDeviceTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool isConnected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isConnected ? AppColors.primary.withAlpha(26) : Colors.red.withAlpha(26),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: isConnected ? AppColors.primary : Colors.red,
                size: 20,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textLight,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: isConnected ? AppColors.primary : Colors.red,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: Colors.grey.shade400,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Divider(height: 1, color: Colors.grey.shade200),
    );
  }
}
