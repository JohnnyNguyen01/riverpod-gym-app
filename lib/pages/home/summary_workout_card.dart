import 'package:flutter/material.dart';

class _BuildWorkoutCard extends StatelessWidget {
  List<String> exercises = [
    "3 x Squat (Barbell)",
    "3 x Leg Extension (Machine)",
    "3 x Squat (Flat leg raise)",
    "3 x Squat (Dumbbell)"
        "3 x Squat (Barbell)",
    "3 x Leg Extension (Machine)",
    "3 x Squat (Flat leg raise)",
    "3 x Squat (Dumbbell)"
  ];
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
