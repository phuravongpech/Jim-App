import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../theme/theme.dart';

class JimNavBar extends StatelessWidget {
  const JimNavBar({super.key});

  // Define routes and icons
  static final List<String> _routes = [
    '/workout',
    '/exercise',
    '/log',
    '/profile',
  ];

  static final List<IconData> _icons = [
    Icons.home,
    Icons.assignment,
    Icons.bar_chart,
    Icons.person,
  ];

  int _getSelectedIndex() => _routes.indexOf(Get.currentRoute);

  @override
  Widget build(BuildContext context) {
    final selectedIndex = _getSelectedIndex();

    return NavigationBar(
      backgroundColor: JimColors.white,
      indicatorColor: JimColors.primary,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
      selectedIndex: selectedIndex,
      onDestinationSelected: (index) => Get.offNamed(_routes[index]),
      destinations: List.generate(
        _icons.length,
        (index) => NavigationDestination(
          icon: Icon(
            _icons[index],
            color: selectedIndex == index ? Colors.white : JimColors.black,
          ),
          selectedIcon: Icon(_icons[index], color: Colors.white),
          label: '',
        ),
      ),
    );
  }
}
