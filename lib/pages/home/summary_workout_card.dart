import 'package:flutter/material.dart';

class BuildWorkoutCard extends StatelessWidget {
  final List<String> exercises;

  BuildWorkoutCard({this.exercises});

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
                "Legs",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text("Last performed: 3 days ago"),
              SizedBox(height: 3),
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: exercises.length,
                  itemBuilder: (_, itemCount) {
                    return Text(exercises[itemCount]);
                  })
            ],
          ),
        ),
      ),
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      onTap: () {},
      onTapDown: (tdd) {},
    );
  }
}
