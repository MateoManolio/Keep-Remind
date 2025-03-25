import '../../core/data_state/data_state.dart';
import '../../core/interfaces/i_usecase.dart';
import '../entities/note.dart';
import '../i_repositories/i_database_repository.dart';

class UpdateNoteUsecase implements IUsecase<DataState<dynamic>, Note> {
  final IDatabaseRepository databaseRepository;

  UpdateNoteUsecase({required this.databaseRepository});

  @override
  Future<DataState<dynamic>> call(Note params) async {
    try {
      await databaseRepository.updateNote(params);
      return DataState.success(params);
    } catch (e) {
      return DataState.error(e.toString());
    }
  }
}
