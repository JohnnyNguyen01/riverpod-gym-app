import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gym_tracker/domain/authentication/models/exercise_model.dart';

class ExerciseTable extends StatelessWidget {
  final Exercise exercise;

  ExerciseTable({@required this.exercise});

  @override
  Widget build(BuildContext context) {
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      defaultColumnWidth: FixedColumnWidth(80),
      columnWidths: {3: FixedColumnWidth(15)},
      children: _buildRows(),
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
          SizedBox(width: 1),
          Text("REPS")
        ],
      ),
    );
    //create a table row for each set
    for (int i = 0; i < sets; i++) {
      rows.add(TableRow(children: [
        Text(i.toString()),
        Text("-"),
        _BuildInputTextField(),
        SizedBox(width: 5),
        _BuildInputTextField(),
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
