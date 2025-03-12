import 'package:keep_n_remind/src/domain/entities/note.dart';
import 'package:objectbox/objectbox.dart';

import '../../core/data_state/data_state.dart';
import '../../domain/i_repositories/i_database_repository.dart';
import '../models/note_dto.dart';

class DatabaseRepository implements IDatabaseRepository {
  final Box<NoteDto> _notesBox;

  DatabaseRepository({required Box<NoteDto> notesBox}) : _notesBox = notesBox;

  @override
  Future<void> saveNotes(List<Note> notes) async {
    _notesBox.putMany(notes.map((e) => NoteDto.fromEntity(e)).toList());
  }

  @override
  Future<DataState<List<Note>>> getAllNotes() async {
    try {
      return DataState.success(
        _notesBox.getAll().map((e) => e.toEntity()).toList(),
      );
    } catch (e) {
      return DataState.error(e.toString());
    }
  }

  @override
  Future<void> deleteNote(Note note) async {
    _notesBox.remove(NoteDto.fromEntity(note).id);
  }

  @override
  Future<void> updateNote(Note note) async {
    _notesBox.put(NoteDto.fromEntity(note));
  }

  @override
  Future<void> createNote(Note note) async {
    _notesBox.put(NoteDto.fromEntity(note));
  }

  @override
  Future<void> deleteAllNotes() async {
    _notesBox.removeAll();
  }
}
