import '../../core/interfaces/i_usecase.dart';
import '../../domain/entities/note.dart';

class SendController {
  final IUsecase<dynamic, List<Note>> _saveNotesUsecase;
  final IUsecase<dynamic, Note> _deleteNoteUsecase;

  SendController({
    required IUsecase<dynamic, List<Note>> saveNotesUsecase,
    required IUsecase<dynamic, Note> deleteNoteUsecase,
  })  : _saveNotesUsecase = saveNotesUsecase,
        _deleteNoteUsecase = deleteNoteUsecase;

  Future<void> saveNotes(List<Note> notes) async {
    await _saveNotesUsecase.call(notes);
  }

  Future<void> deleteNote(Note note) async {
    await _deleteNoteUsecase.call(note);
  }
}
