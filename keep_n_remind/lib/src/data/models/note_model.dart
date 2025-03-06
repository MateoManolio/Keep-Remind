import 'package:flutter/material.dart';

import '../../domain/entities/note.dart';

class NoteModel {
  int? id;
  String? title;
  String? shortDescription;
  String? content;
  String? leadingIcon;
  List<String>? tags;
  DateTime? alarmAt;

  NoteModel({
    this.id,
    required this.title,
    required this.shortDescription,
    required this.content,
    required this.leadingIcon,
    required this.tags,
    required this.alarmAt,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      id: json['id'],
      title: json['title'],
      shortDescription: json['shortDescription'],
      content: json['content'],
      leadingIcon: json['leadingIcon'],
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e.toString()).toList(),
      alarmAt: DateTime.tryParse(json['alarmAt'] ?? ''),
    );
  }

  static List<NoteModel> fromListJson(List<dynamic> json) {
    return json.map((e) => NoteModel.fromJson(e)).toList();
  }

  Note toEntity({required IconData leadingIcon, required DateTime createdAt}) {
    return Note(
      id: id,
      title: title ?? '',
      shortDescription: shortDescription ?? '',
      content: content ?? '',
      leadingIcon: leadingIcon,
      tags: tags,
      alarmAt: alarmAt,
      createdAt: createdAt,
    );
  }
}
