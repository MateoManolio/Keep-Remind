import 'package:flutter/material.dart';

class Note {
  final int? id;
  String title;
  String shortDescription;
  String content;
  IconData? leadingIcon;
  List<String>? tags;
  final DateTime createdAt;
  DateTime? alarmAt;

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
