import 'dart:ffi';

import 'package:my_goals/model/goal_template.dart';

class Goal {
  final Long goalId;
  final GoalTemplate goalTemplate;
  final String frequency;

  Goal(
      {required this.goalId,
      required this.goalTemplate,
      required this.frequency});
}
