import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_goals/cubit/selected_goal_template_cubit.dart';
import 'package:my_goals/model/goal_template.dart';

class GoalTemplatesDropdown extends StatefulWidget {
  const GoalTemplatesDropdown({super.key, required this.goalTemplates});

  final List<GoalTemplate> goalTemplates;



  @override
  State<GoalTemplatesDropdown> createState() => _GoalTemplatesDropdownState();
}

class _GoalTemplatesDropdownState extends State<GoalTemplatesDropdown> {


  List<DropdownMenuEntry<GoalTemplate>> generateEntries(List<GoalTemplate>? goalTemplates) {
    List<DropdownMenuEntry<GoalTemplate>> dropdownMenuEntries = [];
    if (goalTemplates == null) {
      return dropdownMenuEntries;
    }
    dropdownMenuEntries = List.generate(goalTemplates.length, (index) {
      return DropdownMenuEntry(value: goalTemplates[index], label: goalTemplates[index].name);
    });
    return dropdownMenuEntries;
  }

  @override
  Widget build(BuildContext context) {

    return DropdownMenu<GoalTemplate>(
      onSelected: (value) {
        context.read<SelectedGoalTemplateCubit>().set(value);
        print(context.read<SelectedGoalTemplateCubit>().state);
      },
      dropdownMenuEntries: generateEntries(widget.goalTemplates)
    );
  }
}
