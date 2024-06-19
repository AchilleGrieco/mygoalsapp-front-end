import 'dart:ffi';


class GoalTemplate {
  final Long goalId;
  final String name;
  final String icon;

  GoalTemplate(
      {required this.goalId,
      required this.name,
      required this.icon});
}
