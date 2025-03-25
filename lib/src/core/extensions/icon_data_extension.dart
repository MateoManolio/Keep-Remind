import 'package:flutter/material.dart';

extension IconDataSerialization on IconData {
  String toIconString() {
    return '$codePoint,${fontFamily ?? ""},${fontPackage ?? ""},$matchTextDirection';
  }

  static IconData fromIconString(String iconString) {
    final parts = iconString.split(',');
    if (parts.length != 4) {
      throw FormatException("El formato del string de IconData no es válido");
    }
    return IconData(
      int.parse(parts[0]),
      fontFamily: parts[1].isNotEmpty ? parts[1] : null,
      fontPackage: parts[2].isNotEmpty ? parts[2] : null,
      matchTextDirection: parts[3].toLowerCase() == 'true',
    );
  }
}
