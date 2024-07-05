import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_goals/cubit/goal_templates_cubit.dart';
import 'package:my_goals/cubit/selected_icon_cubit.dart';
import 'package:my_goals/model/goal_template.dart';
import 'package:my_goals/pages/icons_dropdown.dart';

class GoalTemplateBottomSheet extends StatefulWidget {
  const GoalTemplateBottomSheet(
      {super.key, this.goalTemplate, required this.method});

  final GoalTemplate? goalTemplate;
  final String method;

  @override
  State<GoalTemplateBottomSheet> createState() =>
      _GoalTemplateBottomSheetState();
}

class _GoalTemplateBottomSheetState extends State<GoalTemplateBottomSheet> {
  late TextEditingController nameController;
  late String errorMessage;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.goalTemplate?.name);
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 50, 40, 50),
      child: Column(
        children: [
          const Text("Name"),
          TextField(
            controller: nameController,
          ),
          const Text("Icon"),
          IconsDropDown(goalTemplate: widget.goalTemplate),
          ElevatedButton(
              onPressed: () {
                IconData? icon = context.read<SelectedIconCubit>().state;
                if (icon == null || nameController.text.isEmpty) {
                  setState(() {
                    errorMessage = "Icon can't be null and name can't be empty";
                  });
                } else {
                  GoalTemplate goalTemplate = GoalTemplate(
                      name: nameController.text,
                      icon: icon.codePoint as String);
                  if (widget.method == "add") {
                    try {
                      context
                          .read<GoalTemplatesCubit>()
                          .addGoalTemplate(goalTemplate, context);
                    } on Exception {
                      setState(() {
                        errorMessage = "Goal Template not added";
                      });
                    }
                  }
                  if (widget.method == "modify") {
                    try {
                      context
                          .read<GoalTemplatesCubit>()
                          .modifyGoalTemplate(goalTemplate, context);
                    } on Exception {
                      setState(() {
                        errorMessage = "Update wans't successful";
                      });
                    }
                  }
                }
              },
              child: const Text("Press")),
          Text(errorMessage)
        ],
      ),
    );
  }
}
