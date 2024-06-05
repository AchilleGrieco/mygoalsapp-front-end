import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_goals/cubit/goals_cubit.dart';
import 'package:my_goals/model/goal.dart';

class GoalCard extends StatelessWidget {
  const GoalCard({super.key, required this.goal});

  final Goal goal;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: const BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(25)),
          color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30, 0, 10, 0),
        child: Row(children: [
          const Icon(
            Icons.run_circle,
            size: 58,
          ),
          const SizedBox(
            width: 30,
          ),
          Text(
            goal.name,
            style: const TextStyle(fontSize: 24),
          ),
          //expanded
          const Expanded(child: SizedBox()),
          IconButton(
            icon: goal.icon,
            onPressed: () {
              context.read<GoalsCubit>().modifyGoal(goal);
            },
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            visualDensity: const VisualDensity(horizontal: -3),
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              context.read<GoalsCubit>().removeGoal(goal);
            },
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            visualDensity: const VisualDensity(horizontal: -3),
          )
        ]),
      ),
    );
  }
}
