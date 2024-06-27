import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_goals/cubit/goals_cubit.dart';
import 'package:my_goals/model/goal.dart';

class GoalCard extends StatelessWidget {
  const GoalCard({super.key, required this.goal});

  final Goal goal;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: null,
      child: Container(
        height: 180,
        width: 155,
        decoration: const BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(18)),
            color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [IconButton(
                onPressed: () {
                  context.read<GoalsCubit>().removeGoal(goal);
                },
                icon: const Icon(Icons.delete),
              )],
            ),
            const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.run_circle,
                  size: 80,
                ),
                Text(
                  "Running",
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  "2 Times a Week",
                  style: TextStyle(fontSize: 12),
                )
              ],
            )
          ]),
        ),
      ),
    );
  }
}
