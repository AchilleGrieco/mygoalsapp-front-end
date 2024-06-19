import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_goals/cubit/goal_templates_cubit.dart';
import 'package:my_goals/model/goal_template.dart';
import 'package:my_goals/pages/goal_template_card.dart';

class Explore extends StatefulWidget {
  const Explore({super.key});

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
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
                  Expanded(child: SizedBox()),
                  Text(
                    "Explore",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Icon(
                        Icons.more_horiz,
                        size: 32,
                        color: Color.fromARGB(255, 54, 50, 50),
                      ),
                    ),
                  )
                ],
              ),
              BlocBuilder<GoalTemplatesCubit, List<GoalTemplate>>(
                builder: (context, state) {
                  return Column(
                    children: List.generate(state.length, (index) {
                      return GoalTemplateCard(
                        goalTemplate: state[index],
                      );
                    }),
                  );
                },
              ),
              const SizedBox(
                height: 40,
              ), // sixedBox dentro goalTemplateCard
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
        ),
      ),
    ]);
  }
}
