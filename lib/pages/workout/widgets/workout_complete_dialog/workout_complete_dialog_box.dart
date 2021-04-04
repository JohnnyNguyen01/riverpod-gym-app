import 'package:flutter/material.dart';
import 'package:gym_tracker/utils/utils.dart';
import 'package:lottie/lottie.dart';

class WorkoutCompleteDialogBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 12, top: 12, right: 12),
        child: Container(
          height: 350,
          child: Column(
            children: [
              LottieBuilder.asset(
                AssetPaths.workoutCompleteLottie,
                width: 180,
                height: 180,
              ),
              const Text(
                'Congratulations !',
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Text(
                'You have successfully completed another workout!',
                style: const TextStyle(fontSize: 15),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
