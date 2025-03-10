import 'package:flutter/material.dart';

import '../entities/send_notes.dart';
import '../../core/data_state/data_state.dart';

abstract class IGeminiRepository {
  Future<DataState<SendNotes>> generateNotes(String prompt);
  Future<DataState<IconData>> generateLeadingIcon(String prompt);
}
