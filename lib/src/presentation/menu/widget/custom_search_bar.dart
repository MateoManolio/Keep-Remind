import 'package:flutter/material.dart';

import '../../../core/utils.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Utils.mediaWidth(context) * 0.6,
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Buscar',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
