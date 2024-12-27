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
      child: Column(
        children: [
          Container(
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
                  children: [
                    IconButton(
                      onPressed: () async {
                        try {
                          if (goal.goalId == null) {
                            throw Exception('Cannot delete goal: Invalid goal ID');
                          }
                          await context
                              .read<GoalsCubit>()
                              .removeGoal(goal, context);
                        } catch (e) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  e.toString().contains('Invalid goal ID')
                                    ? 'Cannot delete goal: Invalid goal ID'
                                    : 'Failed to delete goal. Please try again.',
                                ),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        }
                      },
                      icon: const Icon(Icons.delete),
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      IconData(int.parse(goal.icon), fontFamily: 'MaterialIcons'),
                      size: 70,
                    ),
                    Text(
                      goal.name,
                      style: const TextStyle(fontSize: 18),
                    ),
                    Text(
                      goal.frequency,
                      style: const TextStyle(fontSize: 12),
                    )
                  ],
                )
              ]),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
