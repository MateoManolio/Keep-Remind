import 'package:flutter/material.dart';

import '../../../domain/entities/note.dart';
import '../../widgets/note_card.dart';

class NotesListView extends StatefulWidget {
  const NotesListView({
    super.key,
    required this.notes,
    required this.onDelete,
    required this.onEdit,
  });

  final List<Note> notes;
  final Function(Note) onDelete;
  final Function(Note) onEdit;
  @override
  State<NotesListView> createState() => _NotesListViewState();
}

class _NotesListViewState extends State<NotesListView> {
  late final ScrollController _scrollController;
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  late List<Widget> _noteCards;

  void _removeItem(int index, Note note, bool isNewNote) {
    Widget removedItem = _noteCards[index];

    _noteCards.removeAt(index);
    widget.notes.remove(note);

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
      ...(widget.notes).map(
        (note) => NoteCard.detailed(
          note: note,
          onEdit: widget.onEdit,
          onDelete: (Note note) {
            final index = widget.notes.indexOf(note);
            widget.onDelete(note);
            if (index != -1) {
              _removeItem(index, note, true);
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
        initialItemCount: widget.notes.length,
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
