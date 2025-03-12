import '../../core/data_state/data_state.dart';
import '../../core/interfaces/i_usecase.dart';
import '../../domain/entities/note.dart';
import '../i_repositories/i_database_repository.dart';

class GetAllNotesUsecase extends IUsecase<DataState<List<Note>>, dynamic> {
  final IDatabaseRepository databaseRepository;

  GetAllNotesUsecase({required this.databaseRepository});

  @override
  Future<DataState<List<Note>>> call(dynamic params) async {
    return await databaseRepository.getAllNotes();
  }
}
