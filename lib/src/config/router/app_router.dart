import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:objectbox/objectbox.dart';

import '../../data/models/note_dto.dart';
import '../../data/repositories/database_repository.dart';
import '../../data/repositories/gemini_repository.dart';
import '../../data/repositories/mock_gemini_repository.dart';
import '../../domain/entities/note.dart';
import '../../domain/entities/send_notes.dart';
import '../../domain/usecase/delete_note_usecase.dart';
import '../../domain/usecase/generate_notes_usecase.dart';
import '../../domain/usecase/get_all_notes_usecase.dart';
import '../../domain/usecase/save_notes_usecase.dart';
import '../../domain/usecase/update_note_usecase.dart';
import '../../presentation/controllers/edit_notes_controller.dart';
import '../../presentation/controllers/home_controller.dart';
import '../../presentation/controllers/menu_page_controller.dart';
import '../../presentation/controllers/send_controller.dart';
import '../../presentation/edit_notes/edit_notes_page.dart';
import '../../presentation/home/home_page.dart';
import '../../config/settings/settings_controller.dart';
import '../settings/settings_page.dart';
import '../../presentation/menu/menu_page.dart';
import '../../presentation/send/send_page.dart';
import '../../sample_feature/sample_item_list_view.dart';
import '../../sample_feature/sample_item_details_view.dart';

class AppRouter {
  final SettingsController settingsController;
  final Box<NoteDto> notesBox;

  AppRouter(this.settingsController, this.notesBox);

  late final GoRouter router = GoRouter(
    initialLocation: HomePage.routeName, //TODO: change to home
    routes: <GoRoute>[
      GoRoute(
        path: HomePage.routeName,
        builder: (BuildContext context, GoRouterState state) {
          return HomePage(
            homeController: HomeController(
              generateNotesUsecase: GenerateNotesUsecase(
                geminiRepository: MockGeminiRepository(),
              ),
            ),
          );
        },
      ),
      GoRoute(
        path: SampleItemListView.routeName,
        builder: (BuildContext context, GoRouterState state) {
          return const SampleItemListView();
        },
      ),
      GoRoute(
        path: SampleItemDetailsView.routeName,
        builder: (BuildContext context, GoRouterState state) {
          return const SampleItemDetailsView();
        },
      ),
      GoRoute(
        path: SettingsPage.routeName,
        builder: (BuildContext context, GoRouterState state) {
          return SettingsPage(controller: settingsController);
        },
      ),
      GoRoute(
        path: SendPage.routeName,
        pageBuilder: (context, state) {
          final notes = state.extra as SendNotes;
          return CustomTransitionPage(
            key: state.pageKey,
            opaque: false,
            barrierColor: Colors.black54,
            barrierDismissible: true,
            child: SendPage(
              notes: notes,
              sendController: SendController(
                saveNotesUsecase: SaveNotesUsecase(
                  databaseRepository: DatabaseRepository(notesBox: notesBox),
                ),
                deleteNoteUsecase: DeleteNoteUsecase(
                  databaseRepository: DatabaseRepository(notesBox: notesBox),
                ),
              ),
            ),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
          );
        },
      ),
      GoRoute(
        path: MenuPage.routeName,
        builder: (BuildContext context, GoRouterState state) {
          return MenuPage(
            menuController: MenuPageController(
              getAllNotesUsecase: GetAllNotesUsecase(
                databaseRepository: DatabaseRepository(notesBox: notesBox),
              ),
              deleteNoteUsecase: DeleteNoteUsecase(
                databaseRepository: DatabaseRepository(notesBox: notesBox),
              ),
            ),
          );
        },
      ),
      GoRoute(
        path: EditNotesPage.routeName,
        builder: (BuildContext context, GoRouterState state) {
          final note = state.extra as Note;
          return EditNotesPage(
            note: note,
            editNotesController: EditNotesController(
              updateNoteUseCase: UpdateNoteUsecase(
                databaseRepository: DatabaseRepository(notesBox: notesBox),
              ),
            ),
          );
        },
      ),
    ],
  );
}
