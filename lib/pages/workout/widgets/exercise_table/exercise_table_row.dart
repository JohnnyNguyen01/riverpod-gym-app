import 'package:flutter/material.dart';
import 'package:gym_tracker/pages/workout/widgets/exercise_table/input_textfield.dart';
import 'package:gym_tracker/pages/workout/widgets/tick_box.dart';

class ExerciseRow extends StatefulWidget {
  final String set;

  ExerciseRow({this.set});

  @override
  _ExerciseRowState createState() => _ExerciseRowState();
}

class _ExerciseRowState extends State<ExerciseRow> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _kgTFController = TextEditingController();

  final _repsTFController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: Form(
        key: _formKey,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(widget.set),
            const SizedBox(width: 15),
            Text("-"),
            const SizedBox(width: 15),
            InputTextField(
              controller: _kgTFController,
            ),
            InputTextField(
              controller: _repsTFController,
            ),
            TickBox(onTapped: () => _formKey.currentState.validate())
          ],
        ),
      ),
    );
  }
}
