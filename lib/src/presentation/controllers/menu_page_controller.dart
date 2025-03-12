import '../../core/data_state/data_state.dart';
import '../../core/data_state/data_status.dart';
import '../../core/interfaces/i_usecase.dart';
import '../../domain/entities/note.dart';

class MenuPageController {
  final IUsecase<DataState<List<Note>>, dynamic> getAllNotesUsecase;
  final IUsecase<dynamic, Note> deleteNoteUsecase;
  List<Note> notes = [];

  MenuPageController({
    required this.getAllNotesUsecase,
    required this.deleteNoteUsecase,
  });

  Future<DataState<List<Note>>> getAllNotes() async {
    if (notes.isEmpty) {
      final result = await getAllNotesUsecase.call(null);
      if (result.status == DataStatus.success) {
        notes = result.data ?? [];
      }
      return result;
    } else {
      return DataState.success(notes);
    }
  }

  void deleteNote(Note note) async {
    await deleteNoteUsecase.call(note);
    notes.remove(note);
  }
}
