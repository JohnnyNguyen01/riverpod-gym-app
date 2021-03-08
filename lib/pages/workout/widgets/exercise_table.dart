import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gym_tracker/domain/authentication/models/exercise_model.dart';
import 'package:gym_tracker/pages/widgets/youtube_player/youtube_player_tile.dart';
import 'package:gym_tracker/pages/workout/widgets/tick_box.dart';

class ExerciseTable extends StatelessWidget {
  final Exercise exercise;
  ExerciseTable({@required this.exercise});

  @override
  Widget build(BuildContext context) {
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
        Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          defaultColumnWidth: FixedColumnWidth(80),
          columnWidths: {
            3: FixedColumnWidth(5),
            5: FixedColumnWidth(5),
            6: FixedColumnWidth(35)
          },
          children: _buildRows(),
        ),
      ],
    );
  }

  List<TableRow> _buildRows() {
    //get all sets
    int sets = int.parse(exercise.sets);
    //Create table row list
    List<TableRow> rows = [];
    //Create Table Header
    rows.add(
      TableRow(
        children: [
          Text("SET"),
          Text("PREVIOUS"),
          Text("KG"),
          SizedBox(width: 1), //[3]spacer
          Text("REPS"),
          SizedBox(width: 1), //[5]spacer
          SizedBox(width: 1),
          SizedBox(width: 1), //[7]spacer
        ],
      ),
    );
    //create a table row for each set
    for (int i = 0; i < sets; i++) {
      rows.add(TableRow(
          decoration: BoxDecoration(
              // color: Color(0xFFEBFCF3),
              ),
          children: [
            Text(i.toString()),
            Text("-"),
            _BuildInputTextField(),
            SizedBox(width: 5),
            _BuildInputTextField(),
            SizedBox(width: 5),
            TickBox(),
            SizedBox(width: 1),
          ]));
    }
    //return table
    return rows;
  }
}

class _BuildInputTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _controller = TextEditingController();
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2),
      height: 39,
      child: TextField(
        inputFormatters: [
          LengthLimitingTextInputFormatter(6),
        ],
        controller: _controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(bottom: 5, left: 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(width: 1),
          ),
        ),
      ),
    );
  }
}
