import 'package:flutter/material.dart';
import 'package:my_goals/model/goal_template.dart';

class GoalTemplateBottomSheet extends StatefulWidget {
  const GoalTemplateBottomSheet({super.key});

  @override
  State<GoalTemplateBottomSheet> createState() =>
      _GoalTemplateBottomSheetState();
}

class _GoalTemplateBottomSheetState extends State<GoalTemplateBottomSheet> {
  TextEditingController nameController = TextEditingController();

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
          Text("Name"),
          TextField(),
          Text("Icon"),
          // come mettere elenco di icons tra cui scegliere?
          ElevatedButton(onPressed: () {
            GoalTemplate.withoutGoalId(name: name, icon: icon)
          }, child: Text("Press"))
        ],
      ),
    );
  }
}
