import 'package:flutter/material.dart';
import 'package:gym_tracker/domain/models/models.dart';

class WorkoutCard extends StatelessWidget {
  final List<Exercise> exercises;
  final String title;
  final String description;
  final Function onTap;
  final Function onTapDown;

  WorkoutCard(
      {this.exercises,
      this.onTap,
      this.onTapDown,
      this.title,
      this.description});

  ///Builds a [Text] widget for each element in [exercises] list laid out
  ///in a column.
  Widget _buildExerciseTextList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var exercise in exercises) Text(exercise.exerciseName)
      ], //exercises.map((exercise) => Text(exercise)).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: MediaQuery.of(context).size.width / 1.25,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text("Last performed: 3 days ago"),
              SizedBox(height: 3),
              Text(
                description,
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
              SizedBox(height: 15),
              _buildExerciseTextList(),
            ],
          ),
        ),
      ),
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      onTap: onTap,
      onTapDown: (tdd) {},
    );
  }
}
