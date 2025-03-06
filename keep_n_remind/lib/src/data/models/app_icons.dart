import 'package:flutter/material.dart';

class AppIcons {
  static const Map<String, IconData> iconMapping = {
    'note': Icons.note,
    'book': Icons.book,
    'work': Icons.work,
    'school': Icons.school,
    'home': Icons.home,
    'event_note': Icons.event_note,
    'person': Icons.person,
    'shopping_cart': Icons.shopping_cart,
    'favorite': Icons.favorite,
    'settings': Icons.settings,
    'alarm': Icons.alarm,
    'calendar_today': Icons.calendar_today,
    'check_circle': Icons.check_circle,
    'delete': Icons.delete,
    'edit': Icons.edit,
    'email': Icons.email,
    'folder': Icons.folder,
    'image': Icons.image,
    'info': Icons.info,
    'list': Icons.list,
    'lock': Icons.lock,
    'map': Icons.map,
    'menu': Icons.menu,
    'notifications': Icons.notifications,
    'phone': Icons.phone,
    'search': Icons.search,
    'star': Icons.star,
    'warning': Icons.warning
  };

  static IconData getIconDataFromString(String? iconName) {
    return iconMapping[iconName ?? 'note'] ?? Icons.note;
  }

  static String getIconNames() {
    return iconMapping.keys.toList().toString();
  }
}
