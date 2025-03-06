import 'package:flutter/material.dart';

class Utils {
  static double mediaHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double mediaWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }
}
