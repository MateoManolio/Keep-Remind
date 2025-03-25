import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/utils.dart';
import '../../../domain/entities/note.dart';

class EditAlarm extends StatefulWidget {
  const EditAlarm({
    super.key,
    required this.note,
    required this.onUpdate,
  });

  final Note note;
  final Function(Note) onUpdate;

  @override
  _EditAlarmState createState() => _EditAlarmState();
}

class _EditAlarmState extends State<EditAlarm> {
  late Note newNote;

  @override
  void initState() {
    super.initState();
    newNote = widget.note;
  }

  void _showEditAlarmSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
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
              SizedBox(
                height: Utils.mediaHeight(context) * 0.2,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.dateAndTime,
                  minimumDate: DateTime.now(),
                  initialDateTime: newNote.alarmAt,
                  onDateTimeChanged: (DateTime newDateTime) {
                    setState(() {
                      newNote.alarmAt = newDateTime;
                    });
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancelar'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        newNote.alarmAt = null;
                      });
                      widget.onUpdate(newNote);
                      Navigator.pop(context);
                    },
                    child: const Text('Eliminar'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      widget.onUpdate(newNote);
                      Navigator.pop(context);
                    },
                    child: const Text('Guardar'),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          onPressed: () => _showEditAlarmSheet(context),
          child: const Text('Editar Alarma'),
        ),
        if (newNote.alarmAt != null)
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Text(
              DateFormat('dd/MM - HH:mm').format(
                newNote.alarmAt!,
              ),
              style: const TextStyle(
                color: Colors.redAccent,
              ),
            ),
          ),
      ],
    );
  }
}
