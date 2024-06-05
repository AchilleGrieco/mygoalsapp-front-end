import 'dart:ffi';

import 'package:my_goals/model/goal.dart';

class ChoosedGoal {
  final Long choosedGoalId;
  final Goal goal;
  final String frequency;

  ChoosedGoal(
      {required this.choosedGoalId,
      required this.goal,
      required this.frequency});
}
