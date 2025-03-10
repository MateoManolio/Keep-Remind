import '../../core/data_state/data_state.dart';
import '../../core/interfaces/i_usecase.dart';
import '../entities/send_notes.dart';
import '../i_repositories/i_gemini_repository.dart';

class GenerateNotesUsecase implements IUsecase<DataState<SendNotes>, String> {
  final IGeminiRepository _geminiRepository;

  GenerateNotesUsecase({required IGeminiRepository geminiRepository})
      : _geminiRepository = geminiRepository;

  @override
  Future<DataState<SendNotes>> call(String prompt) async {
    if (prompt.isEmpty) {
      return DataState.error('El prompt no puede estar vacío');
    }
    final sendNotes = await _geminiRepository.generateNotes(prompt);
    return sendNotes;
  }
}
