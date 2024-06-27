import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:my_goals/cubit/goals_cubit.dart';
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
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                child: Row(
                  children: [
                    Column(
                      children: [
                      BlocBuilder<GoalsCubit, List<Goal>>(
                        builder: (context, state) {
                          return Column(
                            children: List.generate(state.length, (index) {
                              return GoalCard(
                                goal: state[index],
                              );
                            }),
                          );
                        },
                      ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Text("add Goal"),
          onPressed: () {
            showCupertinoModalBottomSheet(
                context: context,
                builder: (context) => const GoalBottomSheet());
          },
        ),
        // elenco di goalCards
      )
    ]);
  }
}
