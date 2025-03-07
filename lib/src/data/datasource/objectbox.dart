import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../models/note_dto.dart';
import 'objectbox.g.dart';

class ObjectBox {
  late final Store noteStore;

  late final Box<NoteDto> noteBox;

  ObjectBox._create(this.noteStore) {
    noteBox = noteStore.box<NoteDto>();
  }

  static Future<ObjectBox> create() async {
    final docsDir = await getApplicationDocumentsDirectory();

    final store = await openStore(directory: p.join(docsDir.path, "obx-note"));

    return ObjectBox._create(store);
  }
}
