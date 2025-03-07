import '../../core/interfaces/i_usecase.dart';
import '../entities/note.dart';
import '../i_repositories/i_database_repository.dart';

class SaveNotesUsecase implements IUsecase<dynamic, List<Note>> {
  final IDatabaseRepository _databaseRepository;

  SaveNotesUsecase({required IDatabaseRepository databaseRepository})
      : _databaseRepository = databaseRepository;

  @override
  Future<dynamic> call(List<Note> params) async {
    await _databaseRepository.saveNotes(params);
  }
}
