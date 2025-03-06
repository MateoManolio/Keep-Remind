import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/utils.dart';
import '../../domain/entities/send_notes.dart';
import '../controllers/send_controller.dart';
import '../menu/menu_page.dart';
import 'widgets/notes_list_view.dart';

class SendPage extends StatelessWidget {
  const SendPage({
    super.key,
    required this.notes,
    required this.sendController,
  });

  static const routeName = '/overlay';
  final SendNotes notes;
  final SendController sendController;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        type: MaterialType.transparency,
        child: Container(
          width: Utils.mediaWidth(context) * 0.8,
          height: Utils.mediaHeight(context) * 0.6,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Pantalla superpuesta',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              NotesListView(notes: notes),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () => context.pop(),
                    child: const Text('Cerrar'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      sendController.saveNotes(notes.newNotes ?? []);
                      context.go(MenuPage.routeName);
                    },
                    child: const Text('Confirmar'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
