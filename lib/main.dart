import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

import 'src/app.dart';
import 'src/config/settings/settings_controller.dart';
import 'src/config/settings/settings_service.dart';
import 'src/data/datasource/objectbox.dart';

void main() async {
  await dotenv.load(fileName: ".env");

  final apiKey = dotenv.env['api_key'] ?? '';
  Gemini.init(
    apiKey: apiKey,
  );

  final settingsController = SettingsController(SettingsService());
  await settingsController.loadSettings();

  runApp(MyApp(
    settingsController: settingsController,
    database: await ObjectBox.create(),
  ));
}
