import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final exerciseTableControllerProvider =
    Provider<ExerciseTableController>((ref) {
  return ExerciseTableController(ref.read);
});

class ExerciseTableController {
  final Reader read;
  ExerciseTableController(this.read);

  handleTextFielfOnChanged(TextEditingController controller) {
    log(controller.text);
  }
}
