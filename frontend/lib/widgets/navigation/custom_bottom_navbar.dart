import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:frontend/theme/theme.dart';
import 'package:get/get.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

  int _getSelectedIndex() {
    final currentRoute = Get.currentRoute;
    switch (currentRoute) {
      case '/workout':
        return 0;
      case '/exercise':
        return 1;
      case '/progress':
        return 2;
      case '/profile':
        return 3;
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      index: _getSelectedIndex(),
      onTap: (index) {
        switch (index) {
          case 0:
            Get.offNamed('/workout');
            break;
          case 1:
            Get.offNamed('/exercise');
            break;
          case 2:
            Get.offNamed('/progress');
            break;
          case 3:
            Get.offNamed('/profile');
            break;
        }
      },
      items: const [
        Icon(Icons.home, size: 24),
        Icon(Icons.fitness_center, size: 24),
        Icon(Icons.bar_chart, size: 24),
        Icon(Icons.person, size: 24),
      ],
      backgroundColor: JimColors.backgroundAccent,
      color: JimColors.primary,
      buttonBackgroundColor: JimColors.primary,
      animationDuration: const Duration(milliseconds: 600),
      height: 60,
    );
  }
}
