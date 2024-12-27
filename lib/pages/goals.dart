import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:my_goals/cubit/goals_cubit.dart';
import 'package:my_goals/cubit/selected_goal_template_cubit.dart';
import 'package:my_goals/model/goal.dart';
import 'package:my_goals/pages/goal_bottom_sheet.dart';
import 'package:my_goals/pages/goal_card.dart';

class Goals extends StatelessWidget {
  const Goals({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned.fill(
          child: Image.asset(
        'assets/bg.jpg',
        fit: BoxFit.fill,
      )),
      Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(30, 40, 30, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Goals",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )
                ],
              ),
              BlocBuilder<GoalsCubit, List<Goal>>(
                builder: (context, goals) {
                  if (goals.isEmpty) {
                    return Container(
                      margin: const EdgeInsets.only(top: 16),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.orange.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        "To Create a goal be sure to have goal templates in the explore page. Create your first goal by clicking the + button below",
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                  child: BlocBuilder<GoalsCubit, List<Goal>>(
                    builder: (context, state) {
                      return GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.8,
                        ),
                        itemCount: state.length,
                        itemBuilder: (context, index) {
                          return GoalCard(
                            goal: state[index],
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Text("+"),
          onPressed: () {
            showCupertinoModalBottomSheet(
                context: context,
                builder: (context) => BlocProvider(create: (context) => SelectedGoalTemplateCubit(), child: const GoalBottomSheet(),));
          },
        ),
      )
    ]);
  }
}
