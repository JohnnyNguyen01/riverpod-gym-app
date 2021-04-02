import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/models/models.dart';
import '../tick_box.dart';
import 'exercise_table_row_controller.dart';
import 'input_textfield.dart';

class ExerciseRow extends StatefulWidget {
  final String setNumber;
  final Exercise exercise;

  ExerciseRow({@required this.setNumber, @required this.exercise});

  @override
  _ExerciseRowState createState() => _ExerciseRowState();
}

class _ExerciseRowState extends State<ExerciseRow> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _kgTFController = TextEditingController();
  final _repsTFController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ScopedReader watch, _) {
      final pageController = watch(exerciseTableRowControllerProvider);
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Form(
          key: _formKey,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(widget.setNumber),
              const SizedBox(width: 15),
              Text("-"),
              const SizedBox(width: 15),
              InputTextField(
                controller: _kgTFController,
              ),
              InputTextField(
                controller: _repsTFController,
              ),
              TickBox(
                onTapped: () => pageController.handleOnTickBoxTapped(
                    setNumber: int.parse(widget.setNumber),
                    formKey: _formKey,
                    kgController: _kgTFController,
                    repsController: _repsTFController,
                    exerciseName: widget.exercise.exerciseName),
              )
            ],
          ),
        ),
      );
    });
  }
}
