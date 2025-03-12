import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

import '../../core/data_state/data_state.dart';
import '../../core/data_state/data_status.dart';
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
  Future<DataState<SendNotes>> generateNotes(String prompt) async {
    try {
      final notes = await databaseRepository.getAllNotes();
      final existingNotes =
          notes.data?.map((e) => Part.text(e.toString())).toList() ?? [];

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

        if (newNotes.status == DataStatus.error ||
            updateNotes.status == DataStatus.error) {
          return DataState.error(newNotes.error ?? updateNotes.error);
        }

        return DataState.success(SendNotes(
          newNotes: newNotes.data,
          updateNotes: updateNotes.data,
        ));
      });
    } catch (e) {
      return DataState.error('Error generando la nota: $e');
    }
  }

  Future<DataState<List<Note>>> _getNotes(List<NoteModel> notesModel) async {
    final leadingIcon =
        await generateLeadingIcon(notesModel.first.leadingIcon ?? 'event_note');

    final notes = await Future.wait(
      notesModel.map((note) async {
        return note.toEntity(
          leadingIcon: leadingIcon.data!,
          createdAt: DateTime.now(),
        );
      }),
    );
    if (leadingIcon.status == DataStatus.error) {
      return DataState.error(leadingIcon.error);
    }
    return DataState(
      status: leadingIcon.status,
      data: notes,
    );
  }

  @override
  Future<DataState<IconData>> generateLeadingIcon(String prompt) async {
    try {
      return await Gemini.instance.prompt(parts: [
        Part.text(Prompts.generateLeadingIcon + prompt),
        ...AppIcons.iconMapping.entries.map((e) => Part.text(e.toString())),
      ]).then((value) {
        return DataState.success(AppIcons.getIconDataFromString(value?.output));
      });
    } catch (e) {
      return DataState.error(e.toString());
    }
  }
}
