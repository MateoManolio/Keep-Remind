import 'package:flutter/material.dart';

class Note {
  final int? id;
  final String title;
  final String shortDescription;
  final String content;
  final IconData? leadingIcon;
  final List<String>? tags;
  final DateTime createdAt;
  final DateTime? alarmAt;

  Note({
    this.id,
    required this.title,
    required this.shortDescription,
    required this.content,
    required this.leadingIcon,
    required this.tags,
    required this.createdAt,
    required this.alarmAt,
  });

  @override
  String toString() {
    return '''
# $title

$shortDescription

$content
''';
  }
}
