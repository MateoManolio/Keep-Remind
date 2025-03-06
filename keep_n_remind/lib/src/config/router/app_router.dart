import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:objectbox/objectbox.dart';

import '../../data/models/note_dto.dart';
import '../../data/repositories/database_repository.dart';
import '../../data/repositories/gemini_repository.dart';
import '../../domain/entities/send_notes.dart';
import '../../domain/usecase/generate_notes_usecase.dart';
import '../../domain/usecase/save_notes_usecase.dart';
import '../../presentation/controllers/home_controller.dart';
import '../../presentation/controllers/send_controller.dart';
import '../../presentation/home/home_page.dart';
import '../../config/settings/settings_controller.dart';
import '../../config/settings/settings_view.dart';
import '../../presentation/menu/menu_page.dart';
import '../../presentation/send/send_page.dart';
import '../../sample_feature/sample_item_list_view.dart';
import '../../sample_feature/sample_item_details_view.dart';

class AppRouter {
  final SettingsController settingsController;
  final Box<NoteDto> notesBox;

  AppRouter(this.settingsController, this.notesBox);

  late final GoRouter router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: HomePage.routeName,
        builder: (BuildContext context, GoRouterState state) {
          return HomePage(
            homeController: HomeController(
              generateNotesUsecase: GenerateNotesUsecase(
                geminiRepository: GeminiRepository(
                  databaseRepository: DatabaseRepository(notesBox: notesBox),
                ),
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
        path: SettingsView.routeName,
        builder: (BuildContext context, GoRouterState state) {
          return SettingsView(controller: settingsController);
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
          return const MenuPage();
        },
      ),
    ],
  );
}
