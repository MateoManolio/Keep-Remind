import '../entities/note.dart';

abstract class IDatabaseRepository {
  Future<void> saveNotes(List<Note> notes);
  Future<List<Note>> getNotes();
  Future<void> deleteNote(Note note);
  Future<void> updateNote(Note note);
  Future<void> createNote(Note note);
  Future<void> deleteAllNotes();
}
