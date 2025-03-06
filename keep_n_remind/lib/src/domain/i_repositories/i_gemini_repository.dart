import 'package:flutter/material.dart';

import '../entities/send_notes.dart';

abstract class IGeminiRepository {
  Future<SendNotes> generateNotes(String prompt);
  Future<IconData> generateLeadingIcon(String prompt);
}
