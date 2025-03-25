import 'package:flutter/material.dart';

import '../../../domain/entities/note.dart';

class EditTags extends StatefulWidget {
  const EditTags({
    super.key,
    required this.note,
    required this.onUpdate,
  });

  final Note note;
  final Function(Note) onUpdate;

  @override
  State<EditTags> createState() => _EditTagsState();
}

class _EditTagsState extends State<EditTags> {
  late TextEditingController _tagsController;
  late List<String> tags;

  @override
  void initState() {
    super.initState();
    _tagsController = TextEditingController();
    tags = List.from(widget.note.tags ?? []);
  }

  @override
  void dispose() {
    _tagsController.dispose();
    super.dispose();
  }

  void _addTag(String tag) {
    setState(() {
      tags.add(tag);
      widget.note.tags = List.from(tags);
    });
  }

  void _removeTag(String tag) {
    setState(() {
      tags.remove(tag);
      widget.note.tags = List.from(tags);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setModalState) {
                return Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 16,
                    bottom: 50,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Etiquetas',
                          style: Theme.of(context).textTheme.titleLarge),
                      ListView(
                        shrinkWrap: true,
                        children: [
                          if (tags.isNotEmpty)
                            Wrap(
                              spacing: 8,
                              runSpacing: 4,
                              children: tags
                                  .map((tag) => AnimatedOpacity(
                                        opacity: 1.0,
                                        duration:
                                            const Duration(milliseconds: 300),
                                        child: Chip(
                                          label: Text(tag),
                                          backgroundColor: Colors.grey[200],
                                          elevation: 4,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          onDeleted: () {
                                            setModalState(() {
                                              _removeTag(tag);
                                            });
                                            widget.onUpdate(widget.note);
                                          },
                                        ),
                                      ))
                                  .toList(),
                            ),
                        ],
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: TextField(
                              controller: _tagsController,
                              decoration:
                                  const InputDecoration(labelText: 'Etiquetas'),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (_tagsController.text.isNotEmpty) {
                                setModalState(() {
                                  _addTag(_tagsController.text);
                                  _tagsController.clear();
                                });
                                widget.onUpdate(widget.note);
                              }
                            },
                            child: const Text('Guardar'),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
      child: const Text('Editar Etiquetas'),
    );
  }
}
