import '../../core/data_state/data_state.dart';
import '../../core/interfaces/i_usecase.dart';
import '../entities/note.dart';
import '../i_repositories/i_database_repository.dart';

class DeleteNoteUsecase extends IUsecase<dynamic, Note> {
  final IDatabaseRepository _databaseRepository;

  DeleteNoteUsecase({required IDatabaseRepository databaseRepository})
      : _databaseRepository = databaseRepository;

  @override
  Future<DataState<dynamic>> call(Note params) async {
    await _databaseRepository.deleteNote(params);
    return DataState.success(params);
  }
}
