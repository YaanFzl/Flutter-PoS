import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class PremiumBackground extends StatelessWidget {
  final Widget child;

  const PremiumBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // 1. Light Gradient Background
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFF5F7FA), // Cool White
                Color(0xFFE8F5E9), // Soft Green Tint
                Color(0xFFFFFFFF), // White
              ],
            ),
          ),
        ),

        // 2. Ambient Glows (Subtle Light Mode)
        Positioned(
          top: -100,
          left: -100,
          child: Container(
            width: 500,
            height: 500,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  AppColors.primary.withAlpha(26), // 0.1
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: -150,
          right: -100,
          child: Container(
            width: 600,
            height: 600,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  const Color(0xFF4C9A66).withAlpha(26), // 0.1
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),

        // 3. Child Content
        child,
      ],
    );
  }
}
