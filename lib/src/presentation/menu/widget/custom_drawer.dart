import 'package:flutter/material.dart';

import 'drawer_item.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
          child: Column(
            spacing: 16,
            children: [
              DrawerItem(title: 'Home', onTap: () {}),
              DrawerItem(title: 'Settings', onTap: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
