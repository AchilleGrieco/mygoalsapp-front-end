import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:my_goals/cubit/goal_templates_cubit.dart';
import 'package:my_goals/model/goal_template.dart';
import 'package:my_goals/page/goal_templates/goal_template_bottom_sheet.dart';

class GoalTemplateCard extends StatelessWidget {
  const GoalTemplateCard({super.key, required this.goalTemplate});

  final GoalTemplate goalTemplate;

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
          Icon(
            IconData(int.parse(goalTemplate.icon), fontFamily: 'MaterialIcons'),
            size: 58,
          ),
          const SizedBox(
            width: 30,
          ),
          Text(
            goalTemplate.name,
            style: const TextStyle(fontSize: 20),
          ),
          //expanded
          const Expanded(child: SizedBox()),
          IconButton(
            icon: const Icon(Icons.update),
            onPressed: () {
              showCupertinoModalBottomSheet(
                  context: context,
                  builder: (context) => GoalTemplateBottomSheet(
                        goalTemplate: goalTemplate,
                        method: "modify",
                      ));
            },
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            visualDensity: const VisualDensity(horizontal: -3),
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              try {
                if (goalTemplate.goalId == null) {
                  throw Exception('Cannot delete template: Invalid template ID');
                }
                await context
                    .read<GoalTemplatesCubit>()
                    .removeGoalTemplate(goalTemplate, context);
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        e.toString().contains('Invalid template ID')
                          ? 'Cannot delete template: Invalid template ID'
                          : 'Failed to delete goal template. Please try again.',
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              }
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
