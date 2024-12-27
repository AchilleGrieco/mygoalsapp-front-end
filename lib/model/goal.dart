class Goal {
  final int? goalId;
  String name;
  String icon;
  String frequency;

  Goal(
      {this.goalId,
      required this.name,
      required this.icon,
      required this.frequency});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Goal && other.goalId == goalId;
  }

  @override
  int get hashCode => goalId.hashCode;
}
