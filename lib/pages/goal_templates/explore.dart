import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:my_goals/cubit/goal_templates_cubit.dart';
import 'package:my_goals/cubit/selected_icon_cubit.dart';
import 'package:my_goals/model/goal_template.dart';
import 'package:my_goals/pages/goal_templates/goal_template_bottom_sheet.dart';
import 'package:my_goals/pages/goal_templates/goal_template_card.dart';

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
                    children: List.generate(context.watch<GoalTemplatesCubit>().state.length, (index) {
                      return GoalTemplateCard(
                        goalTemplate: context.read<GoalTemplatesCubit>().state[index],
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
          child: const Text("+"),
          onPressed: () {
            showCupertinoModalBottomSheet(
                context: context,
                builder: (context) => BlocProvider(
                  create: (context) => SelectedIconCubit(), child: const GoalTemplateBottomSheet(method: "add",)));
          },
        ),
      ),
    ]);
  }
}
