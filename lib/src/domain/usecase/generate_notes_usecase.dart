import '../../core/interfaces/i_usecase.dart';
import '../entities/send_notes.dart';
import '../i_repositories/i_gemini_repository.dart';

class GenerateNotesUsecase implements IUsecase<SendNotes, String> {
  final IGeminiRepository _geminiRepository;

  GenerateNotesUsecase({required IGeminiRepository geminiRepository})
      : _geminiRepository = geminiRepository;

  @override
  Future<SendNotes> call(String prompt) async {
    final sendNotes = await _geminiRepository.generateNotes(prompt);
    return sendNotes;
  }
}
