import '../../core/data_state/data_state.dart';
import '../../core/interfaces/i_usecase.dart';
import '../../domain/entities/send_notes.dart';

class HomeController {
  final IUsecase<DataState<SendNotes>, String> _generateNotesUsecase;

  HomeController(
      {required IUsecase<DataState<SendNotes>, String> generateNotesUsecase})
      : _generateNotesUsecase = generateNotesUsecase;

  Future<DataState<SendNotes>> generateNotes(String prompt) async {
    return await _generateNotesUsecase.call(prompt);
  }
}
