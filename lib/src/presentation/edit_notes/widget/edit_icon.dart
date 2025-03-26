import 'package:flutter/material.dart';

import '../../../data/models/app_icons.dart';
import '../../../domain/entities/note.dart';

class EditIcon extends StatefulWidget {
  const EditIcon({
    super.key,
    required this.note,
    required this.onUpdate,
  });

  final Note note;
  final Function(Note) onUpdate;

  @override
  State<EditIcon> createState() => _EditIconState();
}

class _EditIconState extends State<EditIcon> {
  late Note newNote;

  @override
  void initState() {
    super.initState();
    newNote = widget.note;
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Center(
        child: IconButton(
          iconSize: 30,
          onPressed: _editLeadingIcon,
          icon: Icon(newNote.leadingIcon),
        ),
      ),
    );
  }

  void _editLeadingIcon() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return GridView.count(
          crossAxisCount: 5,
          children: List.generate(AppIcons.iconMapping.keys.length, (index) {
            return IconButton(
              icon: Icon(AppIcons.iconMapping.values.toList()[index]),
              onPressed: () {
                setState(() {
                  newNote.leadingIcon =
                      AppIcons.iconMapping.values.toList()[index];
                  Navigator.pop(context);
                  widget.onUpdate(newNote);
                });
              },
            );
          }),
        );
      },
    );
  }
}
