import 'package:flutter/material.dart';
import '../../core/data_state/data_state.dart';
import '../../domain/entities/note.dart';
import '../../domain/entities/send_notes.dart';
import '../../domain/i_repositories/i_gemini_repository.dart';

class MockGeminiRepository implements IGeminiRepository {
  @override
  Future<DataState<SendNotes>> generateNotes(String prompt) async {
    await Future.delayed(const Duration(seconds: 3));
    return DataState.success(
      SendNotes(
        newNotes: [
          Note(
            title: 'Note 1',
            content:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vehicula orci non tortor porta porttitor. Cras condimentum nisl non purus vehicula convallis. Pellentesque congue elit at nibh venenatis finibus. Sed posuere, mauris eu facilisis eleifend, mauris purus blandit eros, ac faucibus leo nulla id ligula. Sed laoreet congue justo eu volutpat. Morbi vestibulum, mi a aliquet ullamcorper, elit turpis faucibus eros, elementum aliquet arcu metus id erat. Nullam interdum posuere feugiat. Nunc consectetur lacinia purus tempor posuere.',
            createdAt: DateTime.now(),
            shortDescription: 'Short Description 1',
            leadingIcon: Icons.add,
            tags: ['tag1', 'tag2'],
            alarmAt: DateTime.now(),
          ),
          Note(
            title: 'Note 2',
            content: 'Content 2',
            createdAt: DateTime.now(),
            shortDescription: 'Short Description 2',
            leadingIcon: Icons.note,
            tags: ['tag3', 'tag4'],
            alarmAt: DateTime.now(),
          ),
        ],
        updateNotes: [
          Note(
            title: 'Note 3',
            content: 'Content 3',
            createdAt: DateTime.now(),
            shortDescription: 'Short Description 3',
            leadingIcon: Icons.abc_outlined,
            alarmAt: DateTime.now(),
            tags: null,
          ),
        ],
      ),
    );
  }

  @override
  Future<DataState<IconData>> generateLeadingIcon(String prompt) async {
    return DataState.success(Icons.add);
  }
}
