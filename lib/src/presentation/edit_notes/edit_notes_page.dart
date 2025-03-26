import 'package:flutter/material.dart';

import '../../domain/entities/note.dart';
import '../controllers/edit_notes_controller.dart';
import 'widget/edit_alarm.dart';
import 'widget/edit_icon.dart';
import 'widget/edit_tags.dart';

class EditNotesPage extends StatefulWidget {
  const EditNotesPage({
    super.key,
    required this.note,
    required this.editNotesController,
  });

  final Note note;
  final EditNotesController editNotesController;

  static const routeName = '/edit-notes';

  @override
  State<EditNotesPage> createState() => _EditNotesPageState();
}

class _EditNotesPageState extends State<EditNotesPage> {
  late TextEditingController _titleController;
  late TextEditingController _shortDescriptionController;
  late TextEditingController _contentController;

  late Note newNote;

  @override
  void initState() {
    super.initState();
    newNote = widget.note;
    _titleController = TextEditingController(text: newNote.title);
    _shortDescriptionController =
        TextEditingController(text: newNote.shortDescription);
    _contentController = TextEditingController(text: newNote.content);

    _titleController.addListener(() {
      newNote.title = _titleController.text;
      Future.delayed(const Duration(milliseconds: 1000), () {
        if (_titleController.text == newNote.title) {
          widget.editNotesController.updateNote(newNote);
        }
      });
    });

    _shortDescriptionController.addListener(() {
      newNote.shortDescription = _shortDescriptionController.text;
      Future.delayed(const Duration(milliseconds: 2000), () {
        if (_shortDescriptionController.text == newNote.shortDescription) {
          widget.editNotesController.updateNote(newNote);
        }
      });
    });

    _contentController.addListener(() {
      newNote.content = _contentController.text;
      Future.delayed(const Duration(milliseconds: 5000), () {
        if (_contentController.text == newNote.content) {
          widget.editNotesController.updateNote(newNote);
        }
      });
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _shortDescriptionController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Notas'),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 40,
          children: [
            Row(
              children: [
                Flexible(
                  flex: 4,
                  child: TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(labelText: 'Título'),
                  ),
                ),
                EditIcon(
                  note: newNote,
                  onUpdate: (Note note) {
                    widget.editNotesController.updateNote(note);
                  },
                ),
              ],
            ),
            TextField(
              controller: _shortDescriptionController,
              decoration: const InputDecoration(labelText: 'Descripción Corta'),
            ),
            Flexible(
              child: TextField(
                controller: _contentController,
                decoration: const InputDecoration(labelText: 'Contenido'),
                expands: true,
                maxLines: null,
                minLines: null,
              ),
            ),
            Column(
              spacing: 14,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EditTags(
                  note: newNote,
                  onUpdate: (Note note) {
                    widget.editNotesController.updateNote(note);
                  },
                ),
                EditAlarm(
                  note: newNote,
                  onUpdate: (Note note) {
                    widget.editNotesController.updateNote(note);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
