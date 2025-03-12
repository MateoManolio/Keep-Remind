import '../../core/data_state/data_state.dart';
import '../entities/note.dart';

abstract class IDatabaseRepository {
  Future<void> saveNotes(List<Note> notes);
  Future<DataState<List<Note>>> getAllNotes();
  Future<void> deleteNote(Note note);
  Future<void> updateNote(Note note);
  Future<void> createNote(Note note);
  Future<void> deleteAllNotes();
}
