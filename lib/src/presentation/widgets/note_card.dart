import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/note.dart';

class NoteCard extends StatelessWidget {
  final Note note;
  final bool simpleView;
  final Function(Note) onEdit;
  final Function(Note) onDelete;
  final Color? color;

  const NoteCard.simple({
    super.key,
    required this.note,
    this.color,
    required this.onEdit,
    required this.onDelete,
  }) : simpleView = true;

  const NoteCard.detailed({
    super.key,
    required this.note,
    this.color,
    required this.onEdit,
    required this.onDelete,
  }) : simpleView = false;

  @override
  Widget build(BuildContext context) {
    return simpleView ? _buildSimpleView(context) : _buildDetailedView(context);
  }

  Widget _buildSimpleView(BuildContext context) {
    final createdAtFormatted = DateFormat('dd/MM/yyyy').format(note.createdAt);
    final alarmFormatted = note.alarmAt != null
        ? DateFormat('HH:mm dd/MM/yyyy').format(note.alarmAt!)
        : null;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: color,
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  createdAtFormatted,
                  style: const TextStyle(color: Colors.grey),
                  textAlign: TextAlign.end,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (note.leadingIcon != null) ...[
                      Icon(note.leadingIcon,
                          size: 32, color: Colors.blueAccent),
                      const SizedBox(width: 8),
                    ],
                    Expanded(
                      child: Text(
                        note.title,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              note.shortDescription,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 12),
            if (note.tags != null && note.tags!.isNotEmpty)
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: note.tags!
                    .map((tag) => Chip(
                          label: Text(tag),
                          backgroundColor: Colors.grey[200],
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ))
                    .toList(),
              ),
            if (alarmFormatted != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  children: [
                    const Icon(Icons.alarm, size: 16, color: Colors.redAccent),
                    const SizedBox(width: 4),
                    Text(
                      'Alarma: $alarmFormatted',
                      style: const TextStyle(
                        color: Colors.redAccent,
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              spacing: 8,
              children: [
                TextButton(
                  onPressed: () {
                    onEdit(note);
                  },
                  child: const Text("Edit"),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.red,
                    backgroundColor: Colors.red.withAlpha(25),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                      side: const BorderSide(color: Colors.red, width: 0.5),
                    ),
                  ),
                  onPressed: () {
                    onDelete(note);
                  },
                  child: const Text("Delete"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailedView(BuildContext context) {
    final createdAtFormatted = DateFormat('dd/MM/yyyy').format(note.createdAt);
    final alarmFormatted = note.alarmAt != null
        ? DateFormat('dd/MM - HH:mm').format(note.alarmAt!)
        : null;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (note.leadingIcon != null) ...[
                  Icon(note.leadingIcon, size: 32, color: Colors.blueAccent),
                  const SizedBox(width: 8),
                ],
                Expanded(
                  child: Text(
                    note.title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                Text(
                  createdAtFormatted,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              note.content,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 12),
            if (note.tags != null && note.tags!.isNotEmpty)
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: note.tags!
                    .map((tag) => Chip(
                          label: Text(tag),
                          backgroundColor: Colors.grey[200],
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ))
                    .toList(),
              ),
            if (alarmFormatted != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.alarm,
                            size: 16, color: Colors.redAccent),
                        const SizedBox(width: 4),
                        Text(
                          'Alarma: $alarmFormatted',
                          style: const TextStyle(
                            color: Colors.redAccent,
                          ),
                        ),
                      ],
                    ),
                    _buildPopupMenu(context),
                  ],
                ),
              ),
            if (alarmFormatted == null) _buildPopupMenu(context),
          ],
        ),
      ),
    );
  }

  Widget _buildPopupMenu(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: PopupMenuButton<String>(
        icon: const Icon(Icons.more_vert),
        onSelected: (value) {
          switch (value) {
            case 'edit':
              onEdit(note);
              break;
            case 'delete':
              onDelete(note);
              break;
          }
        },
        itemBuilder: (BuildContext context) => [
          const PopupMenuItem<String>(
            value: 'edit',
            child: Row(
              children: [
                Icon(Icons.edit, color: Colors.blue),
                SizedBox(width: 8),
                Text('Editar'),
              ],
            ),
          ),
          const PopupMenuItem<String>(
            value: 'delete',
            child: Row(
              children: [
                Icon(Icons.delete, color: Colors.red),
                SizedBox(width: 8),
                Text('Eliminar'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
