import 'dart:ffi';

class Goal {
  final Long goalId;
  final String name;
  final String icon;
  final String frequency;

  Goal(
      {required this.goalId,
      required this.name,
      required this.icon,
      required this.frequency});
}
