import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

import '../../core/promps.dart';
import '../../domain/entities/note.dart';
import '../../domain/entities/send_notes.dart';
import '../../domain/i_repositories/i_database_repository.dart';
import '../../domain/i_repositories/i_gemini_repository.dart';
import '../models/app_icons.dart';
import '../models/note_model.dart';

class GeminiRepository implements IGeminiRepository {
  GeminiRepository({
    required this.databaseRepository,
  });

  final IDatabaseRepository databaseRepository;

  @override
  Future<SendNotes> generateNotes(String prompt) async {
    try {
      final notes = await databaseRepository.getNotes();
      final existingNotes = notes.map((e) => Part.text(e.toString())).toList();
      final text = Prompts.generateNote + prompt;
      return await Gemini.instance.prompt(parts: [
        Part.text(text),
        ...existingNotes,
      ]).then((value) async {
        final json = jsonDecode((value?.output ?? '').substring(
            (value?.output ?? '').indexOf('{'),
            (value?.output ?? '').lastIndexOf('}') + 1));

        final updateNotesModel = NoteModel.fromListJson(json["update"] ?? []);
        final newNotesModel = NoteModel.fromListJson(json["new"] ?? []);

        final newNotes = await _getNotes(newNotesModel);
        final updateNotes = await _getNotes(updateNotesModel);

        return SendNotes(
          newNotes: newNotes,
          updateNotes: updateNotes,
        );
      });
    } catch (e) {
      throw Exception('Error generando la nota: $e');
    }
  }

  Future<List<Note>> _getNotes(List<NoteModel> notes) {
    return Future.wait(
      notes.map((note) async {
        return note.toEntity(
          leadingIcon:
              await generateLeadingIcon(note.leadingIcon ?? 'event_note'),
          createdAt: DateTime.now(),
        );
      }),
    );
  }

  @override
  Future<IconData> generateLeadingIcon(String prompt) async {
    try {
      return await Gemini.instance.prompt(parts: [
        Part.text(Prompts.generateLeadingIcon + prompt),
        ...AppIcons.iconMapping.entries.map((e) => Part.text(e.toString())),
      ]).then((value) {
        return AppIcons.getIconDataFromString(value?.output);
      });
    } catch (e) {
      return Icons.note;
    }
  }
}
