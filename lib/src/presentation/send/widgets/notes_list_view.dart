import 'package:flutter/material.dart';

import '../../../domain/entities/note.dart';
import '../../../domain/entities/send_notes.dart';
import '../../widgets/note_card.dart';

class NotesListView extends StatefulWidget {
  const NotesListView({super.key, required this.notes});

  final SendNotes notes;

  @override
  State<NotesListView> createState() => _NotesListViewState();
}

class _NotesListViewState extends State<NotesListView> {
  late final ScrollController _scrollController;
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  late List<Widget> _noteCards;

  int get _itemCount =>
      (widget.notes.newNotes?.length ?? 0) +
      (widget.notes.updateNotes?.length ?? 0);

  void _removeItem(int index, Note note, bool isNewNote) {
    Widget removedItem = _noteCards[index];

    _noteCards.removeAt(index);
    if (isNewNote) {
      widget.notes.newNotes?.remove(note);
    } else {
      widget.notes.updateNotes?.remove(note);
    }

    _listKey.currentState?.removeItem(
      index,
      (context, animation) => SizeTransition(
        sizeFactor: animation,
        child: FadeTransition(
          opacity: animation,
          child: removedItem,
        ),
      ),
      duration: const Duration(milliseconds: 300),
    );
  }

  void _buildNoteCards() {
    _noteCards = [
      ...(widget.notes.newNotes ?? []).map(
        (note) => NoteCard.simple(
          note: note,
          color: Colors.green.shade100,
          onEdit: (Note note) {},
          onDelete: (Note note) {
            final index = widget.notes.newNotes?.indexOf(note) ?? -1;
            if (index != -1) {
              _removeItem(index, note, true);
            }
          },
        ),
      ),
      ...(widget.notes.updateNotes ?? []).map(
        (note) => NoteCard.simple(
          note: note,
          color: Colors.blue.shade100,
          onEdit: (Note note) {},
          onDelete: (Note note) {
            final index = widget.notes.updateNotes?.indexOf(note) ?? -1;
            if (index != -1) {
              _removeItem(index, note, false);
            }
          },
        ),
      ),
    ];
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _buildNoteCards();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(50);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AnimatedList(
        key: _listKey,
        controller: _scrollController,
        initialItemCount: _itemCount,
        itemBuilder: (context, index, animation) {
          return SizeTransition(
            sizeFactor: animation,
            child: FadeTransition(
              opacity: animation,
              child: _noteCards[index],
            ),
          );
        },
      ),
    );
  }
}
