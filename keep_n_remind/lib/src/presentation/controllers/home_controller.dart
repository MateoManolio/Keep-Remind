import '../../core/interfaces/i_usecase.dart';
import '../../domain/entities/send_notes.dart';

class HomeController {
  final IUsecase<SendNotes, String> _generateNotesUsecase;

  HomeController({required IUsecase<SendNotes, String> generateNotesUsecase})
      : _generateNotesUsecase = generateNotesUsecase;

  Future<SendNotes> generateNotes(String prompt) async {
    return await _generateNotesUsecase.call(prompt);
  }
}
