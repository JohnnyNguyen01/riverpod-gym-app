import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_tracker/domain/authentication/models/exercise_model.dart';
import 'package:gym_tracker/pages/widgets/youtube_player/youtube_player_tile.dart';
import 'package:gym_tracker/pages/workout/widgets/exercise_table/exercise_table_controller.dart';
import 'package:gym_tracker/pages/workout/widgets/tick_box.dart';

class ExerciseTable extends ConsumerWidget {
  final Exercise exercise;
  ExerciseTable({@required this.exercise});

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final _exerciseTableController = watch(exerciseTableControllerProvider);

    List<Widget> _buildFormRows() {
      List<Widget> rows = [];
      int sets = int.parse(exercise.sets);
      for (int i = 1; i < sets; i++) {
        rows.add(_BuildExerciseRow(set: i.toString()));
      }
      return rows;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          exercise.exerciseName,
          style: Theme.of(context).textTheme.headline6,
        ),
        const SizedBox(height: 8),
        YoutubePlayerTile(
          url: exercise.exerciseURL,
        ),
        const SizedBox(height: 8),
        _BuildRowHeader(),
        Column(children: _buildFormRows())
      ],
    );
  }
}

class _BuildRowHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Set"),
          Text("Previous"),
          Text("Kg"),
          const SizedBox(width: 20),
          Text("Reps"),
          const SizedBox(width: 20),
          const SizedBox(width: 15),
        ],
      ),
    );
  }
}

class _BuildExerciseRow extends StatelessWidget {
  final String set;
  final _formKey = GlobalKey<FormState>();
  final _kgTFController = TextEditingController();
  final _repsTFController = TextEditingController();
  _BuildExerciseRow({this.set});

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
            Text(set),
            const SizedBox(width: 15),
            Text("-"),
            const SizedBox(width: 15),
            _BuildInputTextField(
              controller: _kgTFController,
            ),
            _BuildInputTextField(
              controller: _repsTFController,
            ),
            TickBox(onTapped: () => print(_formKey.toString()))
          ],
        ),
      ),
    );
  }
}

class _BuildInputTextField extends StatelessWidget {
  // final int keyValue;
  final TextEditingController controller;
  _BuildInputTextField({@required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2),
      height: 39,
      width: 80,
      child: TextFormField(
        // key: Key(keyValue.toString()),
        inputFormatters: [
          LengthLimitingTextInputFormatter(6),
        ],
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(bottom: 5, left: 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(width: 1),
          ),
        ),
        // onChanged: (value) => print(
        //   controller.toString(),
        // ),
        onTap: () => print(controller.toString()),
      ),
    );
  }
}
