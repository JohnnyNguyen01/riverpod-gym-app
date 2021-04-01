import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:gym_tracker/domain/models/models.dart';
import 'package:gym_tracker/states/states.dart';
import '../../../widgets/youtube_player/youtube_player_tile.dart';
import 'exercise_table_controller.dart';
import 'exercise_table_row.dart';

class ExerciseTable extends ConsumerWidget {
  final Exercise exercise;
  ExerciseTable({@required this.exercise});

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final _exerciseTableController = watch(exerciseTableControllerProvider);

    Widget _buildFormListView() {
      int _sets = int.parse(exercise.sets);
      return ListView.builder(
          shrinkWrap: true,
          itemCount: _sets,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return ExerciseRow(
              setNumber: index.toString(),
              exercise: exercise,
            );
          });
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          exercise.exerciseName,
          style: Theme.of(context).textTheme.headline6,
        ),
        const SizedBox(height: 8),
        //todo: uncomment below after testing
        YoutubePlayerTile(
          url: exercise.exerciseURL,
        ),
        const SizedBox(height: 8),
        _BuildRowHeader(),
        _buildFormListView()
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
