import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'custom_search_bar.dart';

class MenuAppBar extends StatelessWidget {
  const MenuAppBar({
    super.key,
  });

  static const double spacing = 20;
  static const double iconSize = 28;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: spacing,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: Icon(Icons.menu, size: iconSize),
          ),
        ),
        CustomSearchBar(),
        IconButton(
          onPressed: () => context.pop(),
          icon: Icon(Icons.logout, size: iconSize),
        ),
      ],
    );
  }
}
