import '../../core/data_state/data_state.dart';
import '../../core/interfaces/i_usecase.dart';
import '../entities/note.dart';
import '../i_repositories/i_database_repository.dart';

class SaveNotesUsecase implements IUsecase<DataState<dynamic>, List<Note>> {
  final IDatabaseRepository _databaseRepository;

  SaveNotesUsecase({required IDatabaseRepository databaseRepository})
      : _databaseRepository = databaseRepository;

  @override
  Future<DataState<dynamic>> call(List<Note> params) async {
    try {
      await _databaseRepository.saveNotes(params);
      return DataState.success(params);
    } catch (e) {
      return DataState.error(e.toString());
    }
  }
}
