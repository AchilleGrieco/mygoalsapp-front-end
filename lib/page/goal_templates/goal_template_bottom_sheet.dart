import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_goals/cubit/goal_templates_cubit.dart';
import 'package:my_goals/cubit/selected_icon_cubit.dart';
import 'package:my_goals/model/goal.dart';
import 'package:my_goals/model/goal_template.dart';
import 'package:my_goals/component/icons_dropdown.dart';

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
  String errorMessage = "";

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.goalTemplate?.name);
    if (widget.method == "modify" && widget.goalTemplate != null) {
      context
          .read<SelectedIconCubit>()
          .set(int.parse(widget.goalTemplate!.icon));
    } else if (widget.method == "add") {
      context.read<SelectedIconCubit>().set(Icons.home.codePoint);
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    IconsDropDown iconsDropDown = IconsDropDown(
      goalTemplate: widget.goalTemplate,
    );

    // Always use the current state from SelectedIconCubit
    Icon icon = Icon(
      IconData(context.watch<SelectedIconCubit>().state,
          fontFamily: 'MaterialIcons'),
    );

    return Padding(
        padding: const EdgeInsets.fromLTRB(40, 50, 40, 50),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Name"),
              TextField(
                controller: nameController,
                keyboardType: TextInputType.text,
                maxLength: 12,
                decoration: const InputDecoration(
                  counterText: "",
                  hintText: "Enter the name",
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                ),
              ),
              icon,
              const Text("Icon"),
              iconsDropDown,
              ElevatedButton(
                  onPressed: () {
                    int? icon = context.read<SelectedIconCubit>().state;
                    if (nameController.text.isEmpty) {
                      setState(() {
                        errorMessage =
                            "Icon can't be null and name can't be empty";
                      });
                    } else {
                      if (widget.method == "add") {
                        try {
                          GoalTemplate goalTemplate = GoalTemplate(
                              name: nameController.text, icon: icon.toString());
                          context
                              .read<GoalTemplatesCubit>()
                              .addGoalTemplate(goalTemplate, context);
                          Navigator.pop(context);
                        } on Exception {
                          setState(() {
                            errorMessage = "Goal Template not added";
                          });
                        }
                      }
                      if (widget.method == "modify") {
                        try {
                          widget.goalTemplate!.name = nameController.text;
                          widget.goalTemplate!.icon = icon.toString();
                          context.read<GoalTemplatesCubit>().modifyGoalTemplate(
                              widget.goalTemplate!, context);
                          Navigator.pop(context);
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
        ));
  }
}
