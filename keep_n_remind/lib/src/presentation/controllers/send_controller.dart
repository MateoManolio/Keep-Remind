import '../../core/interfaces/i_usecase.dart';
import '../../domain/entities/note.dart';

class SendController {
  final IUsecase<dynamic, List<Note>> _saveNotesUsecase;

  SendController({required IUsecase<dynamic, List<Note>> saveNotesUsecase})
      : _saveNotesUsecase = saveNotesUsecase;

  Future<void> saveNotes(List<Note> notes) async {
    await _saveNotesUsecase.call(notes);
  }
}
