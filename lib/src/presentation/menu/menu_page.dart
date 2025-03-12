import 'package:flutter/material.dart';

import '../../core/data_state/data_status.dart';
import '../../domain/entities/note.dart';
import '../controllers/menu_page_controller.dart';
import 'widget/custom_drawer.dart';
import 'widget/menu_appbar.dart';
import 'widget/notes_list_view.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({
    super.key,
    required this.menuController,
  });

  static const routeName = '/menu';
  final MenuPageController menuController;

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  late List<Note> notes = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    widget.menuController.getAllNotes().then(
      (value) {
        if (value.status == DataStatus.success) {
          setState(() {
            notes = value.data ?? [];
            isLoading = false;
          });
        } else {
          setState(() {
            isLoading = false;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      body: SafeArea(
        child: Column(
          children: [
            const MenuAppBar(),
            const Divider(),
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : NotesListView(
                    notes: notes,
                    onDelete: (note) {
                      widget.menuController.deleteNote(note);
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
