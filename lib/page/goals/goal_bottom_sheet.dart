import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_goals/cubit/goal_templates_cubit.dart';
import 'package:my_goals/cubit/goals_cubit.dart';
import 'package:my_goals/cubit/selected_goal_template_cubit.dart';
import 'package:my_goals/model/goal.dart';
import 'package:my_goals/model/goal_template.dart';
import 'package:my_goals/page/goal_templates/goal_templates_dropdown.dart';

class GoalBottomSheet extends StatefulWidget {
  const GoalBottomSheet({super.key});

  @override
  State<GoalBottomSheet> createState() => _GoalBottomSheetState();
}

class _GoalBottomSheetState extends State<GoalBottomSheet> {
  late TextEditingController frequencyController;
  String errorMessage = "";
  late List<GoalTemplate> goalTemplates;

  @override
  void initState() {
    super.initState();
    frequencyController = TextEditingController();
  }

  @override
  void dispose() {
    frequencyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    goalTemplates = context.read<GoalTemplatesCubit>().state;

    return
      Padding(
        padding: const EdgeInsets.fromLTRB(40, 50, 40, 50),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("GoalTemplates"),
              GoalTemplatesDropdown(
                goalTemplates: goalTemplates,
              ),
              const Text("Frequency"),
              TextField(
                controller: frequencyController,
                keyboardType: TextInputType.text,
                maxLength: 20,
                decoration: const InputDecoration(
                  counterText: "",
                  hintText: "e.g. 3 times per week",
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    GoalTemplate? goalTemplate =
                        context.read<SelectedGoalTemplateCubit>().state;
                    if (goalTemplate == null || frequencyController.text.isEmpty) {
                      setState(() {
                        errorMessage =
                            "GoalTemplate can't be null and frequency can't be empty";
                      });
                    } else {
                      Goal goal = Goal(
                          name: goalTemplate.name,
                          icon: goalTemplate.icon,
                          frequency: frequencyController.text);
                      try {
                        context.read<GoalsCubit>().addGoal(goal, context);
                        Navigator.pop(context);
                      } on Exception {
                        throw Exception();
                      }
                    }
                  },
                  child: const Text("Press")),
              Text(errorMessage)
            ],
          ),
        ),
      );
  }
}
