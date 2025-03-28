import 'package:objectbox/objectbox.dart';

import '../../core/extensions/icon_data_extension.dart';
import '../../domain/entities/note.dart';

@Entity()
class NoteDto {
  @Id()
  int id;
  final String title;
  final String shortDescription;
  final String content;
  final String leadingIcon;
  final List<String>? tags;
  @Property(type: PropertyType.date)
  final DateTime createdAt;
  @Property(type: PropertyType.date)
  final DateTime? alarmAt;

  NoteDto({
    this.id = 0,
    required this.title,
    required this.shortDescription,
    required this.content,
    required this.leadingIcon,
    required this.tags,
    required this.createdAt,
    required this.alarmAt,
  });

  Note toEntity() => Note(
        id: id,
        title: title,
        shortDescription: shortDescription,
        content: content,
        leadingIcon: IconDataSerialization.fromIconString(leadingIcon),
        tags: tags,
        createdAt: createdAt,
        alarmAt: alarmAt,
      );

  static NoteDto fromEntity(Note entity) => NoteDto(
        id: entity.id ?? 0,
        title: entity.title,
        shortDescription: entity.shortDescription,
        content: entity.content,
        leadingIcon: entity.leadingIcon?.toIconString() ?? '',
        tags: entity.tags,
        createdAt: entity.createdAt,
        alarmAt: entity.alarmAt,
      );
}
