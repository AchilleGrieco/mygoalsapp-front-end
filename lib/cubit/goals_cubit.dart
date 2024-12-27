import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_goals/model/goal.dart';
import 'package:my_goals/service/goal_service.dart';

class GoalsCubit extends Cubit<List<Goal>> {
  GoalsCubit(super.goals);

  GoalService goalService = GoalService();

  void addGoal(Goal goal, BuildContext context) async {
    final createdGoal = await goalService.addGoal(goal, context);
    List<Goal> newState = List.from(state);
    newState.add(createdGoal);
    emit(newState);
  }

  Future<void> removeGoal(Goal goal, BuildContext context) async {
    await goalService.removeGoal(goal.goalId!, context);
    List<Goal> newState = List.from(state);
    newState.remove(goal);
    emit(newState);
  }

  void modifyGoal(Goal goal, BuildContext context) {
    goalService.modifyGoal(goal, context);
    int index = state.indexOf(goal);
    state.removeAt(index);
    state.insert(index, goal);
    emit(state);
  }
}
