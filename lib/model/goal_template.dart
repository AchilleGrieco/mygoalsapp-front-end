class GoalTemplate {
  final int? goalId;
  String name;
  String icon;

  GoalTemplate({this.goalId, required this.name, required this.icon});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is GoalTemplate && other.goalId == goalId;
  }

  @override
  int get hashCode => goalId.hashCode;
}
