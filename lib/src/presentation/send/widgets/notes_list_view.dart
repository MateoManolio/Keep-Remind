import 'package:flutter/material.dart';

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
  late final int itemCount;
  late final List<Widget> noteCards;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    itemCount = (widget.notes.newNotes?.length ?? 0) +
        (widget.notes.updateNotes?.length ?? 0);

    noteCards = [
      ...(widget.notes.newNotes ?? []).map(
        (note) => NoteCard.simple(
          note: note,
          color: Colors.green.shade100,
        ),
      ),
      ...(widget.notes.updateNotes ?? []).map(
        (note) => NoteCard.simple(
          note: note,
          color: Colors.blue.shade100,
        ),
      ),
    ];

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
      child: ListView.builder(
        controller: _scrollController,
        shrinkWrap: true,
        itemCount: itemCount,
        itemBuilder: (context, index) => noteCards[index],
      ),
    );
  }
}
