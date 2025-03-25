import '../../core/data_state/data_state.dart';
import '../../core/interfaces/i_usecase.dart';
import '../../domain/entities/note.dart';

class EditNotesController {
  final IUsecase<DataState<dynamic>, Note> updateNoteUseCase;

  EditNotesController({required this.updateNoteUseCase});

  void updateNote(Note note) {
    updateNoteUseCase.call(note);
  }
}
